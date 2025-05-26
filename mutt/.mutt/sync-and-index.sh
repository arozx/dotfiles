#!/bin/bash

mbsync disroot-inbox > /dev/null 2>&1
notmuch new > /dev/null 2>&1
