local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Disable shift-lock drag movement
player.DevEnableMouseLock = false  

-- Lock mouse to camera rotation only
UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

-- Force the standard camera
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
