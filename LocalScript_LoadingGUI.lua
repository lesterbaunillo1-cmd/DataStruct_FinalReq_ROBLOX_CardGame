local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- GUI USED MUST BE IN PLAYERGUI
local gui = player:WaitForChild("PlayerGui"):WaitForChild("LoadingGui")

local barBackground = gui:WaitForChild("BarBackground")
local barFill = barBackground:WaitForChild("BarFill")
local percentText = barBackground:WaitForChild("PercentText")
local introImage = gui:WaitForChild("IntroImage")

gui.Enabled = true



--  PROGRESS ANIMATION (0% to 100%)
task.spawn(function()
	for i = 0, 100 do
		percentText.Text = i .. "%"

		-- Move the bar fill
		barFill.Size = UDim2.new(i / 100, 0, barFill.Size.Y.Scale, 0)

		task.wait(0.03)
	end
end)

--  Tell server this player is loaded
PlayerLoaded:FireServer()

--  Wait until server announces all players are ready
AllPlayersReady.OnClientEvent:Wait()


task.wait(5)


--  Fade out IntroImage + Bar

local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Fade Bar Background
TweenService:Create(barBackground, tweenInfo, {
	BackgroundTransparency = 1
}):Play()

-- Fade Bar Fill
TweenService:Create(barFill, tweenInfo, {
	BackgroundTransparency = 1
}):Play()

-- Fade Percent Text
TweenService:Create(percentText, tweenInfo, {
	TextTransparency = 1
}):Play()

-- Fade Intro Image
TweenService:Create(introImage, tweenInfo, {
	ImageTransparency = 1
}):Play()

task.wait(1.6)
gui.Enabled = false
