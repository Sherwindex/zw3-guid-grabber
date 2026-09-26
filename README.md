# GUID Grabber for ZW3 & IW4x

A simple and lightweight tool to quickly retrieve your in-game **GUID** for ZW3 (Zombie Warfare 3) or IW4x.

![Preview](https://github.com/user-attachments/assets/ded892dc-962c-4fa3-9f74-412a61a8d239)

### How to Use

1. Download the latest v4 release:  
   **[Download ZW3_GUID_Grabber.bat](https://github.com/Sherwindex/Iw4x-zw3-guid-grabber/releases/download/v4/ZW3_GUID_Grabber.bat)**
2. Double-click the downloaded file, it works even if the game isn't currently running
3. If it can't find a GUID yet, start ZW3 or IW4x and load into a match (a private match is fine), then run it again
4. Your GUID is automatically copied to the clipboard
5. Go to [stats.zw3.eu/settings](https://stats.zw3.eu/settings), paste it into the **Game GUID** box, and click **Save settings** to link it to your Discord

### Features

- Finds your Modern Warfare 2 install automatically through your Steam library, no need to have the game open
- Falls back to checking for a running `zw3.exe` or `iw4x.exe` process if it can't find you through Steam
- Reads your GUID from the game's `games_mp.log`, or from a `rank_` file in `userraw\scriptdata` if the log isn't available
- Checks that the GUID it finds is actually valid before using it
- Copies it directly to your clipboard in the format the stats site expects
- Works with private matches, no public server needed
- Fully offline: nothing is sent anywhere
- Completely open source: [view the source on GitHub](https://github.com/Sherwindex/Iw4x-zw3-guid-grabber/blob/main/ZW3_GUID_Grabber.bat)

### Troubleshooting

- **"Could not locate your Modern Warfare 2 install folder"**: make sure MW2 is installed through Steam, or start the game so it can be found while running
- **"Could not find your GUID (checked games_mp.log and rank_ files)"**: load into a match first (a private match is fine) so those files get created, then run it again
