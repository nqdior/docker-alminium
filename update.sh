#!/bin/bash
#
# update alminium with outputting logfile
#

# start updating
echo $(date) - update ALMinium ...

# logdir
mkdir -p /var/log/alminium

# exec update
./exec-update.sh 2>&1 | tee /var/log/alminium/daemon.log

