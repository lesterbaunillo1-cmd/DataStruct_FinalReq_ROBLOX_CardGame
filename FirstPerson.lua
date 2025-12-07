local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local holdingRightClick = false

-- camera rotation values
local yaw = 0
local pitch = 0
local sensitivity = 0.2

local maxYaw = 90
local maxPitch = 30

-- mouseDelta buffer
local mouseDelta = Vector2.new()

-- track character
local function setupCharacter(character)
	local head = character:WaitForChild("Head")
	local humanoid = character:WaitForChild("Humanoid")
	-- keep AutoRotate true (don't disable it)
	humanoid.AutoRotate = true
	humanoid.RequiresNeck = true



	-- show full body normally
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("BasePart") then
			child.LocalTransparencyModifier = 0
		end
	end


	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable

	-- store initial head direction
	local initialCFrame = head.CFrame

	RunService:BindToRenderStep("CustomFP", Enum.RenderPriority.Camera.Value, function()
		if holdingRightClick then
			-- update rotation using mouseDelta
			yaw = math.clamp(yaw - mouseDelta.X * sensitivity, -maxYaw, maxYaw)
			pitch = math.clamp(pitch - mouseDelta.Y * sensitivity, -maxPitch, maxPitch)
		end

		mouseDelta = Vector2.new()

		-- apply rotation
		local rot = initialCFrame * CFrame.Angles(math.rad(pitch), math.rad(yaw), 0)
		camera.CFrame = CFrame.new(head.Position) * (rot - rot.Position)
	end)
end

-- character load
player.CharacterAdded:Connect(setupCharacter)
if player.Character then
	setupCharacter(player.Character)
end

-- detect mouse movement
UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if holdingRightClick then
			mouseDelta = mouseDelta + Vector2.new(input.Delta.X, input.Delta.Y)
		end
	end
end)

-- right-click behavior
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = true
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = false
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end)
