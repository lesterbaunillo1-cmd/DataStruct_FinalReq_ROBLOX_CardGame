local player = game.Players.LocalPlayer

-- Set max & min zoom distances
player.CameraMaxZoomDistance = 15   -- how far they can zoom OUT
player.CameraMinZoomDistance = 5    -- how close they can zoom IN

-- Make sure it stays applied
player.CharacterAdded:Connect(function()
	task.wait(0.1)
	player.CameraMaxZoomDistance = 15
	player.CameraMinZoomDistance = 5
end)
