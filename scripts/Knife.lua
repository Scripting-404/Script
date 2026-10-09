-- Knife Animation Multi-Set + Double Jump (R6) + DAMAGE SYSTEM

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

if _G.KnifeAnimCleanup then
	pcall(_G.KnifeAnimCleanup)
end

-- ===== Settings =====
local KNIFE_KEYWORD = "knife"
local ATTACK_COOLDOWN = 0.45
local MAX_JUMPS = 2
local DOUBLE_JUMP_DELAY = 0.15
local KEY_NEXT = Enum.KeyCode.Z
local KEY_PREV = Enum.KeyCode.X

-- ===== settings DAMAGE =====
local DAMAGE_MIN = 15          -- damage minimum per hit (random)
local DAMAGE_MAX = 35          -- damage maksimum per hit (random)
local ATTACK_RANGE = 5         -- radius
local ATTACK_HIT_DELAY = 0.10  -- delay damage
local DAMAGE_TOOL_NAME = "Shotgun"
local DAMAGE_METHOD = "Damage"

local SETS = {
	{
		Name = "1. Classic Stab",
		Equip = "rbxassetid://94160581",
		Hold = "rbxassetid://96559165",
		Attacks = {
			"rbxassetid://96559159",
			"rbxassetid://96559161",
			"rbxassetid://74894663",
			"rbxassetid://74813494",
		},
		DoubleJump = "rbxassetid://85837259",
	},
	{
		Name = "2. Ninja",
		Equip = "rbxassetid://94160581",
		Hold = "rbxassetid://104506550",
		Attacks = {
			"rbxassetid://45873069",
			"rbxassetid://85576403",
			"rbxassetid://48146273",
			"rbxassetid://51343632",
		},
		DoubleJump = "rbxassetid://85837259",
	},
	{
		Name = "3. Quick Lunge",
		Equip = "rbxassetid://94160581",
		Hold = "rbxassetid://62323186",
		Attacks = {
			"rbxassetid://49815113",
			"rbxassetid://80395075",
			"rbxassetid://70989553",
			"rbxassetid://69803991",
		},
		DoubleJump = "rbxassetid://66703957",
	},
	{
		Name = "4. Thrust",
		Equip = "rbxassetid://94160581",
		Hold = "rbxassetid://96559165",
		Attacks = {
			"rbxassetid://32659703",
			"rbxassetid://45914822",
			"rbxassetid://45913583",
			"rbxassetid://74815981",
		},
		DoubleJump = "rbxassetid://85837259",
	},
	{
		Name = "5. Heavy Swing",
		Equip = "rbxassetid://94160581",
		Hold = "rbxassetid://96559165",
		Attacks = {
			"rbxassetid://74897796",
			"rbxassetid://86313418",
			"rbxassetid://86313260",
			"rbxassetid://54432537",
		},
		DoubleJump = "rbxassetid://32659699",
	},
}
-- ======================

local connections = {}
local function track(conn)
	table.insert(connections, conn)
	return conn
end

local allTracks = {}
local setIndex = 1
local onSetChanged = nil
local gui, setLabel

local function isKnife(inst)
	return inst:IsA("Tool") and string.find(string.lower(inst.Name), KNIFE_KEYWORD, 1, true) ~= nil
end

local function updateLabel()
	if setLabel then
		setLabel.Text = SETS[setIndex].Name
	end
end

local function changeSet(delta)
	local old = setIndex
	setIndex = (setIndex - 1 + delta) % #SETS + 1
	updateLabel()
	print("[Knife] Set animasi: " .. SETS[setIndex].Name)
	if onSetChanged then
		onSetChanged(old, setIndex)
	end
end

-- ===== GUI =====
local function buildGui()
	local playerGui = player:WaitForChild("PlayerGui")
	gui = Instance.new("ScreenGui")
	gui.Name = "KnifeAnimGui"
	gui.ResetOnSpawn = false

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 230, 0, 34)
	frame.Position = UDim2.new(0, 10, 1, -50)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BackgroundTransparency = 0.2
	frame.BorderSizePixel = 0
	frame.Parent = gui

	local function makeButton(text, x, delta)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0, 30, 1, 0)
		b.Position = UDim2.new(0, x, 0, 0)
		b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		b.BorderSizePixel = 0
		b.Text = text
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 16
		b.Parent = frame
		track(b.MouseButton1Click:Connect(function()
			changeSet(delta)
		end))
	end

	makeButton("<", 0, -1)
	makeButton(">", 200, 1)

	setLabel = Instance.new("TextLabel")
	setLabel.Size = UDim2.new(0, 170, 1, 0)
	setLabel.Position = UDim2.new(0, 30, 0, 0)
	setLabel.BackgroundTransparency = 1
	setLabel.TextColor3 = Color3.new(1, 1, 1)
	setLabel.Font = Enum.Font.Gotham
	setLabel.TextSize = 14
	setLabel.Parent = frame
	updateLabel()
	gui.Parent = playerGui
end

track(UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == KEY_NEXT then
		changeSet(1)
	elseif input.KeyCode == KEY_PREV then
		changeSet(-1)
	end
end))

-- ===== DAMAGE SYSTEM =====
local function hasDamageToolInInventory()
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack and backpack:FindFirstChild(DAMAGE_TOOL_NAME) then
		return true
	end
	if player.Character and player.Character:FindFirstChild(DAMAGE_TOOL_NAME) then
		return true
	end
	return false
end

local function getDamageTool()
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		local tool = backpack:FindFirstChild(DAMAGE_TOOL_NAME)
		if tool then return tool end
	end
	if player.Character then
		local tool = player.Character:FindFirstChild(DAMAGE_TOOL_NAME)
		if tool then return tool end
	end
	return nil
end

-- Cari HANYA 1 player terdekat dalam range
local function findClosestTarget(range)
	if not player.Character then return nil, nil end
	local myRoot = player.Character:FindFirstChild("HumanoidRootPart")
	if not myRoot then return nil, nil end

	local closest = nil
	local closestDist = range

	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			local char = otherPlayer.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				local root = char:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.Health > 0 then
					local dist = (root.Position - myRoot.Position).Magnitude
					if dist <= closestDist then
						closestDist = dist
						closest = hum
					end
				end
			end
		end
	end
	return closest, closestDist
end

-- Damage 1 player hit
local function applyDamage()
	if not hasDamageToolInInventory() then
		warn("[Knife] Tool '" .. DAMAGE_TOOL_NAME .. "' tidak ada di inventory. Damage dilewati.")
		return
	end

	local tool = getDamageTool()
	if not tool then return end

	local receiver = tool:FindFirstChild("Receiver")
	if not receiver then
		warn("[Knife] Tool '" .. DAMAGE_TOOL_NAME .. "' tidak punya 'Receiver'!")
		return
	end

	local targetHumanoid, dist = findClosestTarget(ATTACK_RANGE)
	if not targetHumanoid then return end

	local dmg = math.random(DAMAGE_MIN, DAMAGE_MAX)

	pcall(function()
		receiver:FireServer(DAMAGE_METHOD, targetHumanoid, dmg)
	end)

	print(string.format("[Knife] Hit %s -%d HP (jarak: %.1f stud)",
		targetHumanoid.Parent.Name, dmg, dist))
end

-- ===== character =====
local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local function load(id, priority, looped)
		local anim = Instance.new("Animation")
		anim.AnimationId = id
		local t = animator:LoadAnimation(anim)
		t.Priority = priority
		t.Looped = looped or false
		table.insert(allTracks, t)
		return t
	end

	local cache = {}
	local function getSet(i)
		if not cache[i] then
			local def = SETS[i]
			local s = {
				equip = load(def.Equip, Enum.AnimationPriority.Action, false),
				hold = load(def.Hold, Enum.AnimationPriority.Action, true),
				attacks = {},
				dj = load(def.DoubleJump, Enum.AnimationPriority.Action3, false),
			}
			for _, id in ipairs(def.Attacks) do
				table.insert(s.attacks, load(id, Enum.AnimationPriority.Action2, false))
			end
			cache[i] = s
		end
		return cache[i]
	end

	local function stopSet(s)
		s.equip:Stop(0.1)
		s.hold:Stop(0.1)
		for _, t in ipairs(s.attacks) do
			t:Stop(0.1)
		end
	end

	local currentTool = nil
	local toolConn = nil
	local lastAttack = 0
	local attackIndex = 0

	local function onEquipped(tool)
		currentTool = tool
		print("[Knife] DIPAKAI: " .. tool.Name)
		local s = getSet(setIndex)
		s.equip:Play()
		s.hold:Play()
		toolConn = tool.Activated:Connect(function()
			if os.clock() - lastAttack < ATTACK_COOLDOWN then return end
			lastAttack = os.clock()

			local cur = getSet(setIndex)
			attackIndex = attackIndex % #cur.attacks + 1
			for _, t in ipairs(cur.attacks) do
				t:Stop(0.05)
			end
			cur.attacks[attackIndex]:Play(0.05)

			-- Damage
			task.delay(ATTACK_HIT_DELAY, applyDamage)
		end)
		track(toolConn)
	end

	local function onUnequipped()
		print("[Knife] TIDAK DIPAKAI")
		currentTool = nil
		if toolConn then
			toolConn:Disconnect()
			toolConn = nil
		end
		stopSet(getSet(setIndex))
	end

	onSetChanged = function(oldIndex, newIndex)
		attackIndex = 0
		if cache[oldIndex] then
			stopSet(cache[oldIndex])
		end
		if currentTool then
			local s = getSet(newIndex)
			s.equip:Play()
			s.hold:Play()
		end
	end

	track(character.ChildAdded:Connect(function(child)
		if isKnife(child) then onEquipped(child) end
	end))
	track(character.ChildRemoved:Connect(function(child)
		if child == currentTool then onUnequipped() end
	end))
	for _, child in ipairs(character:GetChildren()) do
		if isKnife(child) then onEquipped(child) end
	end

	-- ===== DOUBLE JUMP =====
	local jumpCount = 0
	local lastJumpTime = 0

	local function jumpVelocity()
		if humanoid.UseJumpPower then
			return humanoid.JumpPower
		end
		return math.sqrt(2 * workspace.Gravity * humanoid.JumpHeight)
	end

	track(humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping then
			if jumpCount == 0 then
				jumpCount = 1
				lastJumpTime = os.clock()
			end
		elseif newState == Enum.HumanoidStateType.Landed
			or newState == Enum.HumanoidStateType.Running
			or newState == Enum.HumanoidStateType.RunningNoPhysics then
			jumpCount = 0
		end
	end))

	track(UserInputService.JumpRequest:Connect(function()
		local state = humanoid:GetState()
		local inAir = state == Enum.HumanoidStateType.Freefall
			or state == Enum.HumanoidStateType.Jumping
		if inAir and jumpCount >= 1 and jumpCount < MAX_JUMPS
			and os.clock() - lastJumpTime > DOUBLE_JUMP_DELAY then
			jumpCount += 1
			lastJumpTime = os.clock()
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			local v = rootPart.AssemblyLinearVelocity
			rootPart.AssemblyLinearVelocity = Vector3.new(v.X, jumpVelocity(), v.Z)
			getSet(setIndex).dj:Play(0.05)
		end
	end))
end

_G.KnifeAnimCleanup = function()
	for _, c in ipairs(connections) do
		pcall(function() c:Disconnect() end)
	end
	for _, t in ipairs(allTracks) do
		pcall(function() t:Stop(0) end)
	end
	if gui then
		pcall(function() gui:Destroy() end)
	end
	connections, allTracks = {}, {}
	onSetChanged = nil
end

buildGui()
if player.Character then
	task.spawn(setupCharacter, player.Character)
end
track(player.CharacterAdded:Connect(setupCharacter))
