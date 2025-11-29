local item = script.Parent
local primary = item.PrimaryPart

if not primary then
	warn("У модели 67 не задан PrimaryPart!")
	return
end


local startCFrame = primary.CFrame

-- Правила возврата
local FALL_Y = -20       
local MAX_DIST = 200      

while true do
	task.wait(0.5)

	local pos = primary.Position

	local tooLow = pos.Y < FALL_Y
	--local tooFar = (pos - startCFrame.Position).Magnitude > MAX_DIST

	if tooLow or tooFar then
		print("67 упал/улетел — возвращаем на старт")

		-- Если предмет в руках — отцепить Motor6D
		local motor = item:FindFirstChild("CarryMotor", true)
		if motor then
			motor.Part0 = nil
		end

		-- 1. Сбрасываем физику перед телепортом
		for _, p in ipairs(item:GetDescendants()) do
			if p:IsA("BasePart") then
				p.Anchored = false
				p.CanCollide = true
				p.Massless = false
				p.AssemblyLinearVelocity = Vector3.zero
				p.AssemblyAngularVelocity = Vector3.zero
			end
		end

		-- 2. Телепортируем на исходное место
		primary.CFrame = startCFrame

		-- 3. Поднимаем на 0.1 stud, чтобы не застрял
		primary.CFrame *= CFrame.new(0, 0, 0)

		-- 4. ДЕЛАЕМ ВСЮ МОДЕЛЬ ANCHORED
		for _, p in ipairs(item:GetDescendants()) do
			if p:IsA("BasePart") then
				p.Anchored = true
			end
		end
	end
end
