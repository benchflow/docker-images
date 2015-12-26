#!/bin/bash
set -e

/usr/local/bin/envcp -v -a --overwrite --strip .tpl /app/*.tpl /app/; 
# avoid the process to die, so that it can monitored by envconsul
sleep 1000