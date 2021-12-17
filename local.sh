#!/bin/bash

wget https://www.linuxfromscratch.org/lfs/downloads/stable/wget-list
wget --no-check-certificate --input-file=wget-list --continue --directory-prefix=/app
