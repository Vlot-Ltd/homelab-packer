#!/bin/bash

# Fix login.defs
sed -i 's/^UMASK.*/UMASK 027/' /etc/login.defs 
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 60/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 7/' /etc/login.defs

# Disable unwanted filesystem types
for FILESYSTEM in cramfs freevs jffs2 hfs hfsplus udf vfat; do
	echo "install ${FILESYSTEM} /bin/true" >> /etc/modprobe.d/dev-sec.conf
done

# Sort Cron access
chmod 600 /etc/crontab
chmod 600 /etc/cron.hourly
chmod 600 /etc/cron.daily
chmod 600 /etc/cron.weekly
chmod 600 /etc/cron.monthly
chmod 600 /etc/cron.d