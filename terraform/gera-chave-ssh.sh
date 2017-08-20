#!/bin/bash
mkdir ssh_keys/
ssh-keygen -t rsa -b 4096 -C "debug-key" -q -P "" -f ssh_keys/debug-key
chmod 400 ssh_keys/debug-key
chmod 400 ssh_keys/debug-key.pub
