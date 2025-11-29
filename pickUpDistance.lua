local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local PICKUP_DISTANCE = 3

RunService.Heartbeat:Connect(function()
	local character = player.Character
	if not character or not character:FindFirstChild("Head") then return end

	local headPos = character.Head.Position

	for _, item in ipairs(workspace:GetDescendants()) do
		if item:IsA("Model") and item:FindFirstChild("PickupRemote") then
			local primary = item.PrimaryPart
			if primary then
				local dist = (headPos - primary.Position).Magnitude
				if dist < PICKUP_DISTANCE then
					item.PickupRemote:FireServer()
				end
			end
		end
	end
end)
