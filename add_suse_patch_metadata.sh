#!/bin/bash

add_ref() {
	if [ -z $1 ]; then
		echo "A patch filename is required."
		exit 0
	fi

	line1="References: Lenovo x13s patches backport"
	line2="Patch-mainline: not yet, queued in linux-next for under code review"

	awk '/Subject:/{
		need_blank=1;
		print;
		getline;
		if(length($1) != 0) {
			print; need_blank=0;
		};
		print "'"$line1"'";
		print "'"$line2"'";
		if (need_blank) {
			printf("\n");
		};
		next
	}1' $1 > result/$1
}

if [ -d result ]; then
	rm -rf result
fi

mkdir result

for i in `ls *.patch`; do

add_ref $i

done
