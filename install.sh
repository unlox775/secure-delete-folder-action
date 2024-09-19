#!/usr/bin/env bash

echo -n "Installing secure-delete.scpt to $HOME/Library/Scripts/Folder Action Scripts... "
mkdir -p $HOME/Library/Scripts/Folder\ Action\ Scripts
rm -f $HOME/Library/Scripts/Folder\ Action\ Scripts/secure-delete.scpt 
ln secure-delete.scpt $HOME/Library/Scripts/Folder\ Action\ Scripts/secure-delete.scpt 
echo "[DONE]"

# Create the Secure-delete folder in the home directory
mkdir -p ~/Secure-delete

# Get the current working directory
current_dir=$(pwd)

# Set the paths for your resources
png_file="$current_dir/trash-can-red.png"
icns_file="$current_dir/trash-can-red.icns"
rsrc_file="$current_dir/trash-can-red.rsrc"

# Check if the necessary files exist
if [ ! -f "$icns_file" ]; then
    echo "Error: trash-can-red.icns not found in the current directory."
    exit 1
fi

# Apply the .icns icon to the folder using AppleScript
osascript <<EOF
    use framework "Cocoa"
    
    set iconPath to "$icns_file"
    set folderPath to "$HOME/Secure-delete"

    set imageData to (current application's NSImage's alloc()'s initWithContentsOfFile:iconPath)
    (current application's NSWorkspace's sharedWorkspace()'s setIcon:imageData forFile:folderPath options:2)
EOF

# Check if the icon was successfully applied
if [[ $? -eq 0 ]]; then
    echo "Icon successfully applied to ~/Secure-delete."
else
    echo "Failed to apply icon to ~/Secure-delete."
fi

# Encode the file path for the Dock (spaces and special characters need URL encoding)
encoded_folder_path=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$HOME/Secure-delete'))")

# Apply the setting using `defaults write` to add it to the right side of the dock
defaults write com.apple.dock persistent-others -array-add "
<dict>
    <key>tile-data</key>
    <dict>
        <key>file-data</key>
        <dict>
            <key>_CFURLString</key>
            <string>file://$encoded_folder_path</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
        </dict>
        <key>file-type</key>
        <integer>18</integer>  <!-- Use 18 for folders -->
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>  <!-- Set tile-type as directory-tile -->
</dict>"

# Restart the Dock to apply changes
killall Dock

echo "Secure-delete folder added to the Dock."


echo Now open up Folder Actions Setup, and attach the Secure-delete folder in your home directory
echo  ... Then choose secure-delete.scpt as the script to run.
echo " "
echo "REMEMBER: you also need to check the 'Enable Folder Actions' box in the top left corner of the Folder Actions Setup window."

sleep 3
open "/System/Library/CoreServices/Applications/Folder Actions Setup.app"
