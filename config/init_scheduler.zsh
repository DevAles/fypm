#!/bin/zsh

CURRENT_WT=Highlevel
CURRENT_LGT=off

# Highlevel
# School
# Food
# Highload
# Relax
# Sleep

# --------------- WorkTime --------------- #

# -- General --
if [[ $(date +%H%M) -lt 0400 ]]; then
    echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Highlevel" | at 04:00
else
    CURRENT_WT=Highlevel
fi

if [[ $(date +%H%M) -lt 1300 ]]; then
    echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Food" | at 13:00
else
    CURRENT_WT=Food
fi

if [[ $(date +%H%M) -lt 1400 ]]; then
    echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Highload" | at 14:00
else
    CURRENT_WT=Highload
fi

if [[ $(date +%H%M) -lt 1900 ]]; then
    echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Sleep" | at 19:00
else
    CURRENT_WT=Sleep
fi

# -- Saturday --
if [[ $(date +%u) -eq 6 ]]; then
    if [[ $(date +%H%M) -lt 1100 ]]; then
        echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Essential" | at 11:00
    else
        CURRENT_WT=Essential
    fi
    RELAX_HOUR=18

# -- Sunday --
elif [[ $(date +%u) -eq 7 ]]; then
    RELAX_HOUR=17 # Overview

# -- Weekdays --
else
    if [[ $(date +%H%M) -lt 0600 ]]; then
        echo "export DISPLAY=$DISPLAY && $TWBIN/worktime School" | at 06:00
    else
        CURRENT_WT=School
    fi

    RELAX_HOUR=18
fi

if [[ $(date +%H) -lt $RELAX_HOUR ]]; then
    echo "export DISPLAY=$DISPLAY && $TWBIN/worktime Relax" | at $RELAX_HOUR:00
else
    CURRENT_WT=Relax
fi

$TWBIN/worktime $CURRENT_WT

# --------------- Lighting --------------- #
if [[ $(date +%H%M) -lt 1700 ]]; then
    echo "export DISPLAY=$DISPLAY && $MYBIN/lighting night" | at 17:00
else
    CURRENT_LGT=night
fi
if [[ $(date +%H%M) -lt 1800 ]]; then
    echo "export DISPLAY=$DISPLAY && $MYBIN/lighting presleep" | at 18:30
else
    CURRENT_LGT=presleep
fi

$MYBIN/lighting $CURRENT_LGT

# ---------------- Others ---------------- #
#echo "/bin/killall DiscordPTB" | at 18:00
#yes | andrun -2 "echo 'wol $HOSTMAC' | at 06:00"
#
