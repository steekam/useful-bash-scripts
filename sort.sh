#!/bin/bash
function move_to() {
	local file=$1
	local ext=$2
	# common extensions
	word=('docx' 'doc')
	powerpoint=('ppt' 'pptx')
	images=('png' 'jpg' 'jpeg' 'svg' 'gif')
	compressed=('zip' 'zipx' 'rar' 'zoo' 'gz' 'tbz' 'tbz2' 'tgz' 'iso' 'bz')

	if [[ " ${word[*]} " == *"$ext"* ]]; then
		if [ ! -d "word" ]; then
			echo "mkdir word" 
			mkdir word
		fi
		echo "mv $file word"
		mv $file word
	elif [[ " ${powerpoint[*]} " == *"$ext"* ]]; then
		if [ ! -d "powerpoint" ]; then
			echo "mkdir powerpoint" 
			mkdir powerpoint
		fi
		echo "mv $file powerpoint"
		mv $file powerpoint
	elif [[ " ${images[*]} " == *"$ext"* ]]; then
		if [ ! -d "images/$ext" ]; then
			echo "mkdir -p images/$ext" 
			mkdir -p images/$ext
		fi
		echo "mv $file images/$ext"
		mv $file images/$ext
	elif [[ " ${compressed[*]} " == *"$ext"* ]]; then
		if [ ! -d "compressed" ]; then
			echo "mkdir compressed" 
			mkdir compressed
		fi
		echo "mv $file compressed"
		mv $file compressed
	else
		if [ ! -d "$ext" ]; then
			echo "mkdir $ext" 
			mkdir $ext
		fi
		echo "mv $file $ext"
		mv $file $ext
	fi
}

# Extensions to exclude
exclude=('sh')

# save and change IFS
OLDIFS=$IFS
IFS=$'\n'

for file in ./*; do
	ext="${file##*.}"
	filename=$(basename "$file")
	# Is a directory
	if [[ -d $file ]]; then continue
	elif [[ -f $file ]]; then
		if [[ " ${exclude[*]} " != *"$ext"* ]]; then
			move_to $filename $ext
		fi
	fi
done

# restore IFS
IFS=$OLDIFS
