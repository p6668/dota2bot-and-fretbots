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
alias OMGRA80 "sv_cheats 1; script_reload_code bots/Buff/mode/omgra80"
alias OMGRA60 "sv_cheats 1; script_reload_code bots/Buff/mode/omgra60"
alias OMGRA   "sv_cheats 1; script_reload_code bots/Buff/mode/omgra"
alias Normal "sv_cheats 1; script_reload_code bots/Buff/mode/normal"
alias Random "sv_cheats 1; script_reload_code bots/Buff/mode/random"
alias OMGRefresh "sv_cheats 1; script_reload_code bots/Buff/mode/refresh"
```

| Command  | Mode |
|----------|------|
| `OMG80`  | OMG 4+2, bots get 80% of the XP bonus |
| `OMG`    | OMG 4+2, bots get the full XP bonus |
| `OMGRA80` | Like `OMG80`, but every hero's extra spells are re-rolled each time it dies |
| `OMGRA60` | Like `OMGRA80`, but bots get 60% of the XP bonus |
| `OMGRA`  | Like `OMG`, but every hero's extra spells are re-rolled each time it dies |
| `Normal` | Normal game (no extra spells), full XP bonus |
| `Random` | Any of the modes above at random |
| `OMGRefresh` | In-game, OMG modes only: re-roll every hero's extra spells (any number of times) |

- Any player can type `-omgrefresh` in **chat** (any OMG mode, after pre-game starts) to re-roll only their own hero's extra spells. No console needed. Each player gets 2 uses by default; after an OMG mode command has been typed, the host can change this in the console with `omg_refresh_limit <n>` (e.g. `omg_refresh_limit 5`, `0` disables it). It can be changed at any time, and uses already spent still count.

- You can change your mind during the pick phase: just type another command. Once pre-game starts the mode is locked.
- The old `sv_cheats 1; script_reload_code bots/Buff/buff` still works and behaves like `Random`.

See `bBuffFlags` for the script flags.

## Extra spell flags (OMG modes)
In `SpellsMore.lua`:

| Flag | Default | What it does |
|------|---------|--------------|
| `ENABLE_HUMAN_ONLY_SPELLS` | `true` | Human players can roll the spells marked `botBanned = true` in `aba_spell_list.lua` (e.g. Ball Lightning, Time Walk, Rot). Bots never roll them either way. `false`: nobody rolls them. |
| `ENABLE_AUTOCAST_SPELLS` | `true` | Human players can roll the auto-cast and toggle spells listed in `AUTOCAST_SPELLS` (orbs such as Frost Arrows, Arcane Orb, Burning Spear, plus Tar Bomb, Split Shot, Phantom Rush and Pulse Nova), which are banned in `aba_spell_list.lua`. Bots never roll them. `false`: they stay banned. The ones that are not banned (Quill Spray, Bloodlust, Leech Seed, ...) are rolled as usual. |
| `HUMAN_SPELLS_IGNORE_POSITION` | `true` | Human players can sit in any slot, so their spells are weighted by the hero's own roles instead of their slot position. Bots always use their position. `false`: humans use their slot position too. |

It can be use with other bot scripts; just change some stuff accordingly, to suit whichever script. Or use fretbots.