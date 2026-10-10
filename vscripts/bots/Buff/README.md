This script is insprired by [Fretbots](https://github.com/fretmute/fretbots/). It runs in conjuction with the bot script. When playing with AP, bots are typically underpowered due to their tendency to roam and not really farm much.
So, I made this to increase their GPM and XPM. I only care about increasing their GPM and XPM, hence I'm not using Fretbots.

I also added a functionality for bots to get neutral items.

# To Use
1. Launch DotA 2 with console enabled.
2. For local host only, so Create a Lobby. Make sure that `Enable Cheats` is checked. 
3. In Hero Selection (pick phase), open the console, and type one of the mode commands below.
4. The script is now running (`Buff mode enabled!` and `Game Mode: ...` messages in chat).

## Mode commands
One-time setup: copy `cfg/autoexec.cfg` from the root of this repo to `<SteamDir>\steamapps\common\dota 2 beta\game\dota\cfg\autoexec.cfg`, then restart Dota 2. If you already have an `autoexec.cfg` there, add these lines to it instead of overwriting it:
```
alias OMG80  "sv_cheats 1; script_reload_code bots/Buff/mode/omg80"
alias OMG    "sv_cheats 1; script_reload_code bots/Buff/mode/omg"
alias Normal "sv_cheats 1; script_reload_code bots/Buff/mode/normal"
alias Random "sv_cheats 1; script_reload_code bots/Buff/mode/random"
```

| Command  | Mode |
|----------|------|
| `OMG80`  | OMG 4+2, bots get 80% of the XP bonus |
| `OMG`    | OMG 4+2, bots get the full XP bonus |
| `Normal` | Normal game (no extra spells), full XP bonus |
| `Random` | One of the three above at random |

- You can change your mind during the pick phase: just type another command. Once pre-game starts the mode is locked.
- The old `sv_cheats 1; script_reload_code bots/Buff/buff` still works and behaves like `Random`.

See `bBuffFlags` for the script flags.

It can be use with other bot scripts; just change some stuff accordingly, to suit whichever script. Or use fretbots.