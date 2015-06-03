#!/bin/bash
set -x
osadm policy add-role-to-user view demo -n default
osadm policy add-role-to-user admin demo -n demo
