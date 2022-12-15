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
