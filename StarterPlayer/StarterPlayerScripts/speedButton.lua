local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character
local humanoid

local speedLevels = {34, 65, 95} 
local currentLevel = 1

local function setupCharacter()
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")

	currentLevel = 1
	humanoid.WalkSpeed = speedLevels[currentLevel]
end

setupCharacter()

player.CharacterAdded:Connect(setupCharacter)

UIS.InputBegan:Connect(function(input, typing)
	if typing then return end

	if input.KeyCode == Enum.KeyCode.U then
		if humanoid then
			currentLevel += 1
			if currentLevel > #speedLevels then
				currentLevel = 1
			end

			humanoid.WalkSpeed = speedLevels[currentLevel]
		end
	end
end)
