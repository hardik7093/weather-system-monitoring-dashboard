#!/bin/bash

CPU=$(/usr/bin/top -bn1 | /usr/bin/grep "Cpu(s)" | /usr/bin/awk '{print 100 - $8}' | /usr/bin/cut -d. -f1)

RAM=$(/usr/bin/free -h | /usr/bin/awk '/Mem:/ {print $3 " / " $2}')

DISK=$(/usr/bin/df -h / | /usr/bin/awk 'NR==2 {print $5}')

/usr/bin/mysql --defaults-extra-file=/home/ubuntu/.my.cnf weatherdb <<EOF
INSERT INTO system_stats
(cpu_usage,ram_usage,disk_usage)
VALUES
('$CPU','$RAM','$DISK');
EOF
