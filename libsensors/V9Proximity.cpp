/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/select.h>
#include <stdio.h>
#include <stdlib.h>

#include "PS_ALS_common.h"

#include <cutils/log.h>

#include "V9Proximity.h"

/*****************************************************************************/

V9Proximity::V9Proximity(char *dev)
    : SensorBase(dev, "proximity"),
      mEnabled(0),
      mInputReader(4),
      mPendingMask(0),
      mInitialised(0)
{

    mPendingEvents.version = sizeof(sensors_event_t);
    mPendingEvents.sensor = ID_P;
    mPendingEvents.type = SENSOR_TYPE_PROXIMITY;

    open_device();

    if(!mInitialised) mInitialised = initialise();

    if ((!ioctl(dev_fd, PS_ALS_IOCTL_PROX_ON))) {
        mEnabled = ioctl(dev_fd,PS_ALS_IOCTL_PROX_GET_ENABLED);
        setInitialState();
    }

    if (!mEnabled) {
        close_device();
    }
}

V9Proximity::~V9Proximity() {
    if (mEnabled) {
        enable(ID_P,0);
    }
}

int V9Proximity::initialise() {
    struct PS_ALS_cfg cfg;
    FILE * cFile;
    int array[20];
    int i=0;
    int rv;
    char cNum[10] ;
    char cfg_data[100];

    rv = ioctl(dev_fd, PS_ALS_IOCTL_CONFIG_GET, &cfg);
    if(rv) ALOGE("Failed to read Taos defaults from kernel!!!");

    cFile = fopen(PROX_FILE,"r");
    if (cFile != NULL){
        fgets(cfg_data, 100, cFile);
        fclose(cFile);
        if(sscanf(cfg_data,"%hu,%hu,%hhu,%hhu,%hhu,%hhu,%hhu,%hhu,%hhu\n",
              &cfg.prox_threshold_hi,
              &cfg.prox_threshold_lo,
              &cfg.prox_int_time,
              &cfg.prox_adc_time,
              &cfg.prox_wait_time,
              &cfg.prox_intr_filter,
              &cfg.prox_config,
              &cfg.prox_pulse_cnt,
              &cfg.prox_gain
              ) == 9){

            rv = ioctl(dev_fd, PS_ALS_IOCTL_CONFIG_SET, &cfg);
            if(rv) ALOGE("Set proximity data failed!!!");
            else ALOGD("Proximity calibration data successfully loaded from %s",PROX_FILE);

        } else {
            ALOGD("Prximity calibration data is not valid. Using defaults.");
        }

    } else {
        ALOGD("No proximity calibration data found. Using defaults.");
    }
    return 1;
}

int V9Proximity::setInitialState() {
    struct input_absinfo absinfo;
    if (!ioctl(data_fd, EVIOCGABS(EVENT_TYPE_PROXIMITY), &absinfo)) {
        mPendingEvents.distance = indexToValue(absinfo.value);
    }
    return 0;
}

int V9Proximity::enable(int32_t handle, int en) {
    if (handle != ID_P)
        return -EINVAL;

    int newState = en ? 1 : 0;
    int err = 0;

    if (uint32_t(newState) != mEnabled) {
        if (!mEnabled) {
	    open_device();
        }
        int cmd;

        if (newState) {
            cmd =PS_ALS_IOCTL_PROX_ON;
            ALOGD_IF(DEBUG,"PROX ON");
        } else {
            cmd = PS_ALS_IOCTL_PROX_OFF;
            ALOGD_IF(DEBUG,"PROX OFF");
        }
        err = ioctl(dev_fd, cmd);
        err = err<0 ? -errno : 0;
        ALOGE_IF(err, "PS_ALS_IOCTL_XXX failed (%s)", strerror(-err));
        if (!err) {
            if (en) {
                setInitialState();
                mEnabled = 1;
            }
               else
               mEnabled = 0;
        }
        if (!mEnabled) {
            ALOGD_IF(DEBUG,"closing device");
            close_device();
        }
    }
    return err;
}

bool V9Proximity::hasPendingEvents() const {
     return mPendingMask;
}

int V9Proximity::readEvents(sensors_event_t* data, int count)
{
    if (count < 1)
        return -EINVAL;

    ssize_t n = mInputReader.fill(data_fd);
    if (n < 0)
        return n;

    int numEventReceived = 0;
    input_event const* event;
    while (count && mInputReader.readEvent(&event)) {
        int type = event->type;
        if (type == EV_ABS) {
            if (event->code == EVENT_TYPE_PROXIMITY) {
                ALOGD_IF(DEBUG,"Prox value=%i",event->value);
                mPendingEvents.distance = indexToValue(event->value);
            }

        } else if (type == EV_SYN) {
            int64_t time = timevalToNano(event->time);
            if (mEnabled){
                *data++ = mPendingEvents;
                mPendingEvents.timestamp=time;
                count--;
                numEventReceived++;
            }
        } else {
            ALOGE("V9Sensor: unknown event (type=%d, code=%d)",type, event->code);
        }
        mInputReader.next();
    }
    return numEventReceived;
}

float V9Proximity::indexToValue(size_t index) const
{
    return index;
}
