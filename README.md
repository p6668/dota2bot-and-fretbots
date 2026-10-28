# About
This is a customized version of dota2bot. This script uses dota2bot with slightly modified bot behavior. 
This means that the GPM for enemy bots would be around 1000-1200 and bot will be lv30 in 35 mins.

bots from: https://github.com/ryndrb/dota2bot  
fretbots: https://github.com/fretmute/fretbots   
beginner AI: https://steamcommunity.com/sharedfiles/filedetails/?id=1627071163

# Setup Instructions
1. Download the script and extract the files from `vscripts` to your Dota 2 vscripts directory.
This is typically `<SteamDir>\steamapps\common\dota 2 beta\game\dota\scripts\vscripts`.
2. Copy `cfg/autoexec.cfg` to your Dota 2 cfg directory.
This is typically `<SteamDir>\steamapps\common\dota 2 beta\game\dota\cfg`.
If an `autoexec.cfg` already exists there, don't overwrite it; add the `alias` lines from ours to the end of yours instead.
This file adds the short mode commands (`OMG80`, `OMG`, `OMGRA80`, `OMGRA60`, `OMGRA`, `OMGAR`, `Normal`, `Random`, `OMGRefresh`) to the console. Restart Dota 2 after copying it.
3. Launch Dota 2 with the console enabled. The console can be enabled under `Advanced Options`.
![](https://github.com/fretmute/fretbots/blob/master/images/EnableConsole.png)
4. Create a lobby and select `Local Dev Script`. Ensure that `Enable Cheats` is checked; this is required because the scripts use functions that are considered cheats to give gold, items, stats, and experience to the bots. The scripts monitor player chat, and will announce to chat when any player enters cheat commands.
![](https://github.com/fretmute/fretbots/blob/master/images/EnableCheats.png)
5. During the pick phase, open the console and type one of these mode commands:

| Command  | Mode |
|----------|------|
| `OMG80`  | OMG 4+2, bots get 80% of the XP bonus |
| `OMG`    | OMG 4+2, bots get the full XP bonus |
| `OMGRA80` | Like `OMG80`, but every hero's extra spells are re-rolled each time it dies |
| `OMGRA60` | Like `OMGRA80`, but bots get 60% of the XP bonus |
| `OMGRA`  | Like `OMG`, but every hero's extra spells are re-rolled each time it dies |
| `OMGAR`  | OMG All Random: every hero's own spells are removed (talents and innate stay) and it gets 3 random spells + 1 random ultimate instead, with their sub-abilities. Bots get the full XP bonus |
| `Normal` | Normal game (no extra spells), full XP bonus |
| `Random` | Any of the modes above at random, except `OMGAR` |

You can type a different command while still picking to change the mode; once pre-game starts the mode is locked.
In `OMGAR`, humans level their new spells with their own ability points; bots get theirs leveled for them. Invoker, Kez, Lone Druid, Meepo, Morphling, Rubick and Troll Warlord keep their own spells and get the normal OMG extra spells.
In any OMG game (`OMG`, `OMG80`, `OMGRA`, `OMGRA80`, `OMGRA60`, `OMGAR`), type `OMGRefresh` at any time after pre-game starts to re-roll the extra spells of every hero (humans and bots). The new spells are leveled straight up to each hero's current level. You can use it as often as you like.
Any player can also type `-omgrefresh` in the game **chat** (not the console) to re-roll only their own hero's extra spells. Each player can do this 2 times by default; after typing an OMG mode command, the host can change the limit in the console, e.g. `omg_refresh_limit 5`.
In an OMG / OMG80 game, type `OMGRefresh` at any time after pre-game starts to re-roll the extra spells of every hero (humans and bots). The new spells are leveled straight up to each hero's current level. You can use it as often as you like.

Any player can also type `-omgrefresh` in the game **chat** (not the console) to re-roll only their own hero's extra spells. Each player can do this 2 times by default; after typing `OMG` / `OMG80`, the host can change the limit in the console, e.g. `omg_refresh_limit 5`.
If a command says "Unknown command", step 2 didn't take effect. You can still type the full command, e.g. `sv_cheats 1; script_reload_code bots/Buff/mode/omg80`.

6. The script is now running (`Buff mode enabled!` and `Game Mode: ...` messages in chat).
7. The script allows manual hero selection for the enemy team. For example, typing `/all puck` in chat will pick Puck for the enemy.
