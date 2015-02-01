#!/bin/bash
#
# This script will be run at run-time by the docker instance
#

#
# Errors are fatal
#
set -e

#
# Where to log our command output.
#
LOG="/splunk-logs/output.txt"


#
# Install Splunk
#
echo "# "
echo "# Installing Splunk..."
echo "# "
dpkg -i /data-install/splunk.deb 2>&1 | tee -a ${LOG}


echo "# "
echo "# Setting up symlinks for Splunk logs to /splunk-logs/, which is exported from Docker"
echo "# "
/var/splunk/bin/splunk --accept-license status 2>&1 | tee -a ${LOG}
rm -rf /opt/splunk/var/log
ln -s /splunk-logs/ /opt/splunk/var/log


#
# Run Splunk in the foreground
#
echo "# "
echo "# Running Splunk in the foreground..."
echo "# "
/var/splunk/bin/splunk --accept-license start --nodaemon 2>&1 | tee -a ${LOG}


