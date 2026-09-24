# GUID Grabber for ZW3 & IW4x

A simple and lightweight tool to quickly retrieve your in-game **GUID** for ZW3 (Zombie Warfare 3) or IW4x.

![Preview](https://github.com/user-attachments/assets/7256219c-b3bd-49b3-a840-4e7414dd4f4a)

### How to Use

1. Download the latest release:  
   **[Download ZW3_GUID_Grabber.bat](https://github.com/Sherwindex/zw3-guid-grabber/releases/latest/download/ZW3_GUID_Grabber.bat)**
2. Start ZW3 or IW4x and load into a match (a private match works)
3. Double-click the downloaded file
4. Your GUID is automatically copied to the clipboard
5. Go to [stats.zw3.eu/settings](https://stats.zw3.eu/settings), paste it into the **Game GUID** box, and click **Save settings** to link it to your Discord

### Features

- Reads your in-game GUID from the game's `games_mp.log` (works with both `zw3.exe` and `iw4x.exe`)
- Finds the game folder automatically, on any drive
- Copies it directly to your clipboard in the format the stats site expects
- Works with private matches, no public server needed
- Fully offline: nothing is sent anywhere
- Completely open source (right-click → Edit to view the code)

### Troubleshooting

- **"zw3.exe / iw4x.exe is not running"**: start the game first, then run the tool.
- **"No games_mp.log found" or "No join record found"**: load into a match first (a private match is fine) so the log gets created.
