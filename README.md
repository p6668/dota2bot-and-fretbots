# About
This is a customized version of dota2bot mainly for personal use. 
Enabling the buff mode of this script will boost the bots GPM to 1000 (lv30 in 35 mins).

Bots from: https://github.com/ryndrb/dota2bot  
Buff mode code is based on fretbots: https://github.com/fretmute/fretbots   

# Setup Instructions
1. Download the script and extract the files from `vscripts` to your Dota 2 vscripts directory.
This is typically `<SteamDir>\steamapps\common\dota 2 beta\game\dota\scripts\vscripts`.
2. Copy `cfg/autoexec.cfg` to your Dota 2 cfg directory.
This is typically `<SteamDir>\steamapps\common\dota 2 beta\game\dota\cfg`.
If an `autoexec.cfg` already exists there, don't overwrite it; add the `alias` lines from ours to the end of yours instead.
This file adds the short mode commands (`OMG80`, `OMG`, `OMGRA80`, `OMGRA60`, `OMGRA`, `OMGULT`, `OMG200`, `Normal`, `Random`, `OMGRefresh`) to the console. Restart Dota 2 after copying it.
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
| `OMGULT` | OMG 4+2, bots get 2 ultimates and 80% of the XP bonus |
| `OMG200` | OMG 4+2, bots get 200% of the XP bonus (double XP) |
| `Normal` | Normal game (no extra spells), full XP bonus |
| `Random` | Any of the modes above at random |

Note: The baseline XP bonus is around 1000 (combined with the natural experience gain of bots).
You can type a different command while still picking to change the mode; once pre-game starts the mode is locked. In an OMG game, the new spells are leveled straight up to each hero's current level.

### Numpad Quick-Bindings

The `autoexec.cfg` also binds numpad keys for quick mode switching during the pick phase:

| Key | Mode |
|-----|------|
| Numpad 1 | OMG80 |
| Numpad 2 | OMG |
| Numpad 3 | Normal |
| Numpad 4 | OMGULT |
| Numpad 5 | OMG200 |

6. The script is now running (`Buff mode enabled!` and `Game Mode: ...` messages in chat).
7. The script allows manual hero selection for the enemy team. For example, typing `/all puck` in chat will pick Puck for the enemy.

In an OMG game (`OMG`, `OMG80`, `OMGRA`, `OMGRA80`, `OMGRA60`, `OMGULT`, `OMG200`), the following commands can be used in the game **chat** (not the console):
1. Any player can type `-omgrefresh` to re-roll only their own hero's extra spells. Each player can do this 10 times by default; only the host can change the limit in the `console`, e.g. `omg_refresh_limit 50`. The `-omgrefresh` is only available in the first 10 mins by default. After that, the player cannot re-roll the extra spells. The host can change the deadline in the `console`, e.g. `omg_refresh_deadline 50`. 
2. Any player can type `-omgrefreshbot` to re-roll only the bots' extra spells. There is no limits and each time all 5 bots' extra spells will be refreshed. 
3. Any player can type `-key d f` to swap spells from hotkey `d` to `f`. Players can also swap unassigned spell to assigned spell, e.g., `-key f 2`. To view all extra spells, see `-keys`. 
4. Any player can choose a new spell themself: `-spell number name` e.g.  `-spell 1 poison attack`. `number` is the number from -keys (1 = first new spell). `name` can be a part of the full name, e.g., `poison attack` -> `viper_poison_attack`. The spell must be in `aba_spell_list.lua` and not banned. 
