#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

show confirm.png
say "Remove hidden macOS files?"$'\n'$'\n'"Backup SD before continuing."$'\n'

if confirm; then

	progressui &

	# Counter for deleted files
	deleted_files=0

	progress 0 "Removing .DS_Store"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".DS_Store" -depth -exec rm {} \; -print | wc -l)))

	progress 16 "Removing .Trashes"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".Trashes" -depth -exec rm -r {} \; -print | wc -l)))

	progress 32 "Removing ._*"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name "._*" -depth -exec rm {} \; -print | wc -l)))

	progress 48 "Removing .fseventsd"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".fseventsd" -depth -exec rm -r {} \; -print | wc -l)))

	progress 64 "Removing .Spotlight-V100"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".Spotlight-V100" -depth -exec rm -r {} \; -print | wc -l)))
	
	progress 80 "Removing .apdisk"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".apdisk" -depth -exec rm {} \; -print | wc -l)))

	progress 100 "Removing .TemporaryItems"
	deleted_files=$((deleted_files + $(find /mnt/SDCARD/ -name ".TemporaryItems" -depth -exec rm -r {} \; -print | wc -l)))

	progress quit
	
	# Give some time to show okay.png
	sleep 0.1
	
	show okay.png
	
	# Wording based on the number of deleted files
	file_word="files were"
	if [ $deleted_files -eq 1 ]; then
		file_word="file was"
	fi

	say "$deleted_files $file_word deleted."$'\n'
	confirm only
else
	# User canceled
	exit 0
fi