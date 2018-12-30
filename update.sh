#!/bin/bash

YEAR=${1-$(($(date +%Y) + 1))}
mkdir -p html
chromium --headless --disable-gpu --dump-dom "https://www.superjob.ru/proizvodstvennyj_kalendar/$Y/" > "html/superjob$YEAR.html"
chromium --headless --disable-gpu --dump-dom "https://www.consultant.ru/law/ref/calendar/proizvodstvennye/$YEAR/" > "html/consultant$YEAR.html"
./gradlew runSuperjob --args="--input $PWD/html/superjob$YEAR.html --output $PWD/json/superjob$YEAR.json"
./gradlew runConsultant --args="--input $PWD/html/consultant$YEAR.html --output $PWD/json/consultant$YEAR.json"
python3 ./json/join.py
