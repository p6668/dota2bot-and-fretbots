local bot = GetBot()

function GetDesire()

	local currentTime = DotaTime()
	local botLV = bot:GetLevel()

	if currentTime <= 10
	then
		return 0.268
	end

	if currentTime <= 9 * 60
		and botLV <= 7
	then
		return 0.446
	end

	if currentTime <= 12 * 60
		and botLV <= 11
	then
		return 0.369
	end

	if botLV <= 17
	then
		return 0.228
	end

	return 0

end