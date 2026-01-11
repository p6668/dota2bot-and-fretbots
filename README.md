# About
This is a customized version of dota2bot. This script uses dota2bot with slightly modified farming/pushing behavior. 
This means that the GPM for enemy bots would be around 1300-1400 and bot will be lv30 in 30-35 mins.

bots from: https://github.com/ryndrb/dota2bot  
fretbots: https://github.com/fretmute/fretbots   
beginner AI: https://steamcommunity.com/sharedfiles/filedetails/?id=1627071163

# Setup Instructions
1. Download the script and extract the files from `vscripts` to your Dota 2 vscripts directory.
This is typically `<SteamDir>\steamapps\common\dota 2 beta\game\dota\scripts\vscripts`.
2. Launch Dota 2 with the console enabled. The console can be enabled under `Advanced Options`.
![](https://github.com/fretmute/fretbots/blob/master/images/EnableConsole.png)
3. Create a lobby and select `Local Dev Script`. Ensure that `Enable Cheats` is checked; this is required because the scripts use functions that are considered cheats to give gold, items, stats, and experience to the bots. The scripts monitor player chat, and will announce to chat when any player enters cheat commands.
![](https://github.com/fretmute/fretbots/blob/master/images/EnableCheats.png)
4. After starting the game, open the console, and input `sv_cheats 1; script_reload_code bots/Buff/buff`.
5. The script is now running (`Buff mode enabled!` message in chat).