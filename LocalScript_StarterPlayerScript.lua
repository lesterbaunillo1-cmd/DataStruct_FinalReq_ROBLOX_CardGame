local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Wait for PlayerGui + LoadingGui to finish
local playerGui = player:WaitForChild("PlayerGui")

-- Wait until loading GUI is removed or disabled
local loadingGui = playerGui:WaitForChild("LoadingGUI", 10) -- name of your loading screen

if loadingGui then
	-- Wait for it to finish its fade + disable
	repeat task.wait() until loadingGui.Enabled == false
end

-- Now wait for character to fully spawn
local function disableAnimations(character)
	local humanoid = character:WaitForChild("Humanoid")

	-- Disable default animate script
	local animateScript = character:FindFirstChild("Animate")
	if animateScript then
		animateScript.Disabled = true
	end

	-- Stop all playing animations
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		track:Stop()
	end

	-- Prevent new animations
	humanoid.AnimationPlayed:Connect(function(track)
		track:Stop()
	end)
end

player.CharacterAdded:Connect(disableAnimations)

-- If character already loaded:
if player.Character then
	disableAnimations(player.Character)
end
