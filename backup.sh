#!/bin/bash
LANG=en_US.UTF-8
git add .
git commit -m "backup at $(date)"
git push origin master

