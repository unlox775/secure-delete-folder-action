# Secure Delete Folder Action
Really basic, using Mac drop folder action and Applescript, to make a drop folder to securely delete things

## Install

1. Clone the repo, and `cd` into it
2. Run the installer: `./install.sh`
3. Make a folder somewhere in your home directory
   - You can [set the icon](https://support.apple.com/guide/mac-help/change-icons-for-files-or-folders-on-mac-mchlp2313/mac) for this folder to the red trash can in the repo, if you like
   - I also found it useful to drag this folder to the dock as well: <img width="153" alt="Screen Shot 2022-12-15 at 9 27 04 AM" src="https://user-images.githubusercontent.com/431288/207928026-a7fb182d-4112-4261-8dcf-dd406a99be8c.png">
5. Open the "Folder Actions" application (built-in to mac OS, under the Utilities folder):
   - Enable Folder actions (checkbox)
   - The `secure-delete.scpt` you installed should show up as an option on the right side.  Choose that
   - Hit the "+" icon, to add your new folder and link it to the script

## What this does

Secure delete overwrites your file multiple times before removing it. This is important as normal deletion of a file doesn't actually erase anything, it only removes the link that the file system stores noting that the file named X is linked to disk blocks Y, Z and Q. If someone were to just go read blocks Y, Z, and Q after you remove the link they can still read your file just fine.

##  AppleScript Source:

``` applescript
on adding folder items to this_folder after receiving these_items
	try
		tell application "Finder"
			repeat with i from 1 to number of items in these_items
				try
					set this_item to item i of these_items
					set the path_string to this_item as string
					set the final_path to POSIX path of the path_string
					do shell script "/bin/rm -rfP '" & final_path & "'"
				on error error_message
					tell application "Finder"
						display dialog "Error for item " & (this_item as string) ¬
							& ": " & error_message buttons {"Continue", "Cancel"} ¬
							default button 1 giving up after 120
					end tell
				end try
			end repeat
		end tell
	on error error_message
		tell application "Finder"
			display dialog error_message buttons {"Cancel"} ¬
				default button 1 giving up after 120
		end tell
	end try
end adding folder items to
```

