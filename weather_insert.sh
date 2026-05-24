#!/bin/bash

API_KEY="b4a2a7c424cfca90d9294fa0664d6705"
CITY="Pune"

response=$(/usr/bin/curl -s "https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=metric")

TEMP=$(echo "$response" | /usr/bin/jq '.main.temp')
HUMIDITY=$(echo "$response" | /usr/bin/jq '.main.humidity')
CONDITION=$(echo "$response" | /usr/bin/jq -r '.weather[0].main')

/usr/bin/mysql --defaults-extra-file=/home/ubuntu/.my.cnf weatherdb <<EOF
INSERT INTO weather_data
(temperature,humidity,weather_condition,city)
VALUES
('$TEMP','$HUMIDITY','$CONDITION','$CITY');
EOF
