#!/bin/bash
set -x
oadm policy add-role-to-user view demo -n default
oadm policy add-role-to-user admin demo -n demo
