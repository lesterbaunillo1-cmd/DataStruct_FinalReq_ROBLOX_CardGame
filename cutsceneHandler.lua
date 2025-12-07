local player = game.Players.LocalPlayer

-- Wait for PlayerGui to fully load
repeat task.wait() until player:FindFirstChild("PlayerGui")

-- Wait for the UI to actually appear inside PlayerGui
local gui = script.Parent
repeat task.wait() until gui.Parent == player:WaitForChild("PlayerGui")

-- Now continue your normal cutscene
local ts = game:GetService("TweenService")
local camFolder = workspace:WaitForChild("cameras")
local camera = workspace.CurrentCamera
local blackFrame = gui:WaitForChild("blackFrame")
local button = gui:WaitForChild("TextButton")

button.Visible = false
blackFrame.Visible = true

camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = camFolder.cam1.CFrame

local ti = TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

task.wait(2) -- shorter blackscreen

local fade = ts:Create(blackFrame, ti, {BackgroundTransparency = 1})
fade:Play()

ts:Create(camera, ti, {CFrame = camFolder.cam2.CFrame}):Play()

fade.Completed:Wait()
blackFrame.Visible = false

button.Visible = true
ts:Create(button, ti, {TextTransparency = 0}):Play()

button.MouseButton1Click:Connect(function()
	button.Visible = false
	camera.CameraType = Enum.CameraType.Custom
	camera.CameraSubject = player.Character:WaitForChild("Humanoid")
end)

-- failsafe
task.delay(6, function()
	if camera.CameraType ~= Enum.CameraType.Custom then
		camera.CameraType = Enum.CameraType.Custom
		camera.CameraSubject = player.Character:WaitForChild("Humanoid")
	end
end)
