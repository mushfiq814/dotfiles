#!/bin/bash

# Get PID of last run musicplayer process through log
pid=$(cat run.pid)

# kill the process
kill $pid
