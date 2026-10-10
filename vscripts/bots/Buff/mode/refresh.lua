-- Loaded by the OMGRefresh console alias; see bots/Buff/README.md.
-- Re-rolls every hero's extra OMG spells. Buff isn't reloaded: its running timer sees the new
-- BuffSpellRefreshGen on the next tick (bots/Buff/SpellsMore.lua).
if BuffActiveMode ~= 'omg' and BuffActiveMode ~= 'omg80' then
    GameRules:SendCustomMessage('OMGRefresh only works in OMG / OMG80 mode.', 0, 0)
elseif GameRules:State_Get() < DOTA_GAMERULES_STATE_PRE_GAME then
    GameRules:SendCustomMessage('Extra spells are handed out when pre-game starts; nothing to refresh yet.', 0, 0)
else
    BuffSpellRefreshGen = (BuffSpellRefreshGen or 0) + 1
    GameRules:SendCustomMessage('Refreshing everyone\'s extra spells...', 0, 0)
end
