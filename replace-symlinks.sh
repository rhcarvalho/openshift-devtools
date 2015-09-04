#!/bin/sh
for x in `find /data/src/github.com/openshift/origin/_output/local/go/bin -type l`
do
	echo $x
	ln -sf openshift $x
done
