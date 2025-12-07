local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local humanoid = char:WaitForChild("Humanoid")
local head = char:WaitForChild("Head")
local upperTorso = char:WaitForChild("UpperTorso")

local cam = workspace.CurrentCamera

-- get the Neck joint
local neck = upperTorso:WaitForChild("Neck")

-- original neck C0
local origC0 = neck.C0

game:GetService("RunService").RenderStepped:Connect(function()
	local cameraCF = cam.CFrame

	-- get yaw (left and right) and pitch (up and down)
	local lookDir = cameraCF.LookVector
	local charDir = char.HumanoidRootPart.CFrame.LookVector

	local yaw = math.atan2(lookDir.X, lookDir.Z) - math.atan2(charDir.X, charDir.Z)
	local pitch = math.asin(lookDir.Y)

	-- clamp limits to avoid breaking
	yaw = math.clamp(yaw, math.rad(-70), math.rad(70))
	pitch = math.clamp(pitch, math.rad(-30), math.rad(30))

	-- apply rotation to neck
	neck.C0 = origC0 * CFrame.Angles(pitch, yaw, 0)
end)
