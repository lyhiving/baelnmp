#!/bin/bash
/usr/bin/lnmp start
/bin/systemctl start sshd.service
/bin/systemctl start ssh.service