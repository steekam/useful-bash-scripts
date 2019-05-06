#!/bin/bash
exit_on_error() {
	exit_code=$1
	last_command=${@:2}

	if [ $exit_code -ne 0 ]; then
		>&2 echo "\"${last_command}\" command failed with exit code ${exit_code}."
		exit $exit_code
	fi
}
# enable !! command completion
set -o history -o histexpand
clear
# Initialise repo
echo "git init"
git init
# # Set remote
echo "git remote add origin git@github.com:steekam/ICS311-MAD--LABS.git"
git remote add origin git@github.com:steekam/ICS311-MAD--LABS.git
exit_on_error $? !!
# Create project branch
read -p "Branch name(project title): "  branch

inValidInput=true
while $inValidInput; do
read -p "Create branch $branch ? [y/n]" createBranch
	case "$createBranch" in
		y) 
			git checkout -b $branch
			inValidInput=false
			;;
		n)
			echo "---------Exiting-------"
			exit
			inValidInput=false
			;;
		*) 
			echo "Enter valid input"
			;;
	esac
done

# add all filesexit_on_error $? !!
echo "git add ."
git add .

# commit message
read -p "Enter commit message: " commitMessage
echo "git commit -m $commitMessage"
git commit -m "$commitMessage"
exit_on_error $? !!

# Push to origin
echo "git push origin $branch"
git push origin $branch

#remove script from current dir
inValidInput=true
while $inValidInput; do
read -p "Delete script [y/n]?" deleteScript
	case "$deleteScript" in
		y) 
			rm ./android_labs_init.sh
			inValidInput=false
			echo "Done :)"
			;;
		n)
			echo "---------Exiting-------"
			exit
			inValidInput=false
			;;
		*) 
			echo "Enter valid input"
			;;
	esac
done
