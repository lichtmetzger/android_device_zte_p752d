#!/system/bin/sh

setprop wifi.interface wlan0
setprop wifi.chip.type AR_6005
setprop wifi.supp_delay_para 800
setprop wifi.wapi.supported true
setprop ro.tether.denied false

