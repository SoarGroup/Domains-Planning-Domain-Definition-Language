#!/bin/sh

export CLASSPATH=antlr-3.1.3.jar:pddl_trans.jar
rm -rf output

for f in pddl/*; do
	echo $f
	tr '[:upper:]' '[:lower:]' < $f > temp
	if ! java translate temp
	then
		exit $?
	fi
	rm temp
done
