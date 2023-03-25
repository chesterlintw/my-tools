#!/bin/bash

package=$1
src_folder=$2
obs_folder=$3
#Q=echo

function check_path() {

	file_path=$1
	pkg=$2

	if [ -z "$pkg" ]; then
		echo "Empty pkg name."
		exit
	fi

	if [ -z "$file_path" ]; then
		echo "Empty path."
		exit
	fi

	if [ ! -d "$file_path/$pkg" ]; then
		echo "Can't find $file_path/$pkg"
		exit
	fi

}

check_path "$src_folder" "$package"
echo "SRC: $src_folder"

check_path "$obs_folder" "$package"
echo "OBS: $obs_folder"

echo "Comparing $package ..."

ex_patterns=".osc"

diff_list=`diff --exclude=$ex_patterns -r -q $src_folder/$package $obs_folder/$package | awk '{print $2}'`

for i in $diff_list; do
	[ $i == "in" ] && continue
	$Q cp -af $i $obs_folder/$package/
done
