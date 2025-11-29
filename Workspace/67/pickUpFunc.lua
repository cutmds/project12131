local item = script.Parent
local primary = item.PrimaryPart

local ANIMATION_ID = "rbxassetid://105734984996684"
local carrying = false
local track = nil
local motor = nil

local offset = CFrame.new(0, 4.5, -0.5) * CFrame.Angles(0, math.rad(180), 0)

local ArmJoints = {
	"LeftUpperArm",
	"LeftLowerArm",
	"LeftHand",
	"RightUpperArm",
	"RightLowerArm",
	"RightHand"
}

local function lockArms(animator)
	for _, joint in ipairs(ArmJoints) do
		animator:SetJointTransform(joint, CFrame.new(), Enum.JointTransformType.Full)
	end
end

local function unlockArms(animator)
	for _, joint in ipairs(ArmJoints) do
		animator:SetJointTransform(joint, nil, Enum.JointTransformType.Full)
	end
end

local remote = Instance.new("RemoteEvent")
remote.Name = "PickupRemote"
remote.Parent = item


remote.OnServerEvent:Connect(function(player)
	if carrying then return end
	local character = player.Character
	if not character then return end

	local head = character:FindFirstChild("Head")
	local humanoid = character:FindFirstChild("Humanoid")
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not head or not humanoid then return end

	carrying = true

	if not motor then
		motor = Instance.new("Motor6D")
		motor.Name = "CarryMotor"
		motor.Part1 = primary
		motor.Parent = primary
	end

	for _, p in ipairs(item:GetDescendants()) do
		if p:IsA("BasePart") then
			p.CanCollide = false
			p.Massless = true
			p.Anchored = false
		end
	end

	primary:SetNetworkOwner(player)
	motor.Part0 = head
	motor.C0 = offset

	local anim = Instance.new("Animation")
	anim.AnimationId = ANIMATION_ID
	track = humanoid:LoadAnimation(anim)
	track.Looped = true
	track:Play(0, 0, 0)
	track:AdjustWeight(1)

	lockArms(animator)
end)
