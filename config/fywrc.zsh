#!/bin/zsh
# Add fypm and fysm to PATH
export PATH=$PATH:$FYPM_DIR/scripts/pending
export PATH=$PATH:$FYSM_DIR/scripts

source $FYPM_DIR/config/vars.zsh

source $FYPM_DIR/config/aliases.zsh


# Init some fysm scripts if it is the initialization of the system
if test ! -e "$INIT_LOCK" && [ "$DISPLAY" != "" ]; then
    mkdir "$FYSM_TEMP"

    "$FYPM_DIR"/config/init_scheduler.zsh

    _task_poly_daemon_ & disown

    #_verify_eventual_tasks_

    # _verify_active_tasks_ >> /dev/null 2>&1 & disown
    # _verify_alarm_tasks_ >> "$FYSM_PERMA_LOGS/fypm/_verify_alarm_tasks_$(date +%Y-%m-%d)" 2>&1 & disown

    wacom
    frc_rst_poly

    echo "" > "$INIT_LOCK"
fi
