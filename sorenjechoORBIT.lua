local orbitRadius = 10
local orbitSpeed = 1
local targetName = "PlayerNameHere"
local isOrbiting = false
local player = game.Players.LocalPlayer
local guiParent = game:GetService("CoreGui")

pcall(function()
	local test = Instance.new("ScreenGui", guiParent)
	test:Destroy()
end)

if not pcall(function() return guiParent:IsDescendantOf(game) end) then
	guiParent = player:WaitForChild("PlayerGui")
end

local gui = Instance.new("ScreenGui")
gui.Name = "OrbitGUI"
gui.ResetOnSpawn = false
gui.Parent = guiParent

local running = true

player.CharacterAdded:Connect(function()
	running = false
	if gui and gui.Parent then gui:Destroy() end
end)

local function cleanupOnDeath()
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Died:Connect(function()
			running = false
			if gui and gui.Parent then gui:Destroy() end
		end)
	end
end

cleanupOnDeath()

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 230)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local signatureLabel = Instance.new("TextLabel")
signatureLabel.Size = UDim2.new(1, 0, 0, 20)
signatureLabel.Position = UDim2.new(0, 0, 0, 0)
signatureLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
signatureLabel.Text = "JECHO ON TOP"
signatureLabel.TextColor3 = Color3.new(1, 0, 0)
signatureLabel.Font = Enum.Font.Garamond
signatureLabel.TextSize = 14
signatureLabel.TextXAlignment = Enum.TextXAlignment.Center
signatureLabel.TextYAlignment = Enum.TextYAlignment.Center
signatureLabel.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 18)
title.Position = UDim2.new(0, 0, 0, 20)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "Orbit Controller"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 13
title.Parent = frame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -16, 0, 16)
speedLabel.Position = UDim2.new(0, 8, 0, 40)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: " .. orbitSpeed
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 12
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = frame

local speedPresets = {-5, -2, -1, 1, 2, 5}
for i, speed in ipairs(speedPresets) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 50, 0, 20)
	btn.Position = UDim2.new(0, 10 + ((i - 1) % 3) * 55, 0, 60 + math.floor((i - 1) / 3) * 24)
	btn.BackgroundColor3 = (speed < 0) and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(200, 60, 60)
	btn.Text = tostring(speed)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 12
	btn.Parent = frame
	btn.AutoButtonColor = false
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = (speed < 0) and Color3.fromRGB(60, 60, 180) or Color3.fromRGB(180, 40, 40)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = (speed < 0) and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(200, 60, 60)
	end)
	btn.MouseButton1Click:Connect(function()
		orbitSpeed = speed
		speedLabel.Text = "Speed: " .. orbitSpeed
	end)
end

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -16, 0, 18)
inputBox.Position = UDim2.new(0, 8, 0, 110)
inputBox.PlaceholderText = "Target player"
inputBox.Text = targetName
inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 12
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame
inputBox.FocusLost:Connect(function()
	if inputBox.Text ~= "" then
		targetName = inputBox.Text
	end
end)

local distanceBox = Instance.new("TextBox")
distanceBox.Size = UDim2.new(1, -16, 0, 18)
distanceBox.Position = UDim2.new(0, 8, 0, 132)
distanceBox.PlaceholderText = "Orbit radius"
distanceBox.Text = tostring(orbitRadius)
distanceBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
distanceBox.TextColor3 = Color3.new(1, 1, 1)
distanceBox.Font = Enum.Font.SourceSans
distanceBox.TextSize = 12
distanceBox.ClearTextOnFocus = false
distanceBox.Parent = frame

local setDistanceBtn = Instance.new("TextButton")
setDistanceBtn.Size = UDim2.new(1, -16, 0, 20)
setDistanceBtn.Position = UDim2.new(0, 8, 0, 154)
setDistanceBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
setDistanceBtn.Text = "Set Distance"
setDistanceBtn.TextColor3 = Color3.new(1, 1, 1)
setDistanceBtn.Font = Enum.Font.SourceSansBold
setDistanceBtn.TextSize = 12
setDistanceBtn.Parent = frame

local function applyDistance()
	local value = tonumber(distanceBox.Text)
	if value and value > 0 then
		orbitRadius = value
	end
end

distanceBox.FocusLost:Connect(applyDistance)
setDistanceBtn.MouseButton1Click:Connect(applyDistance)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -16, 0, 22)
toggleBtn.Position = UDim2.new(0, 8, 0, 180)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.Text = "Start Orbit"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 13
toggleBtn.Parent = frame

toggleBtn.MouseEnter:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)
toggleBtn.MouseLeave:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
end)
toggleBtn.MouseButton1Click:Connect(function()
	isOrbiting = not isOrbiting
	toggleBtn.Text = isOrbiting and "Stop Orbit" or "Start Orbit"
end)

local function getCharacter(plr)
	return plr.Character or plr.CharacterAdded:Wait()
end

task.spawn(function()
	local angle = 0
	while running do
		if isOrbiting then
			local char = getCharacter(player)
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local targetPlayer = game.Players:FindFirstChild(targetName)
			if targetPlayer and targetPlayer ~= player then
				local targetChar = getCharacter(targetPlayer)
				local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
				if hrp and targetHRP then
					if char:FindFirstChild("Humanoid") then
						char.Humanoid.Sit = false
					end
					angle += orbitSpeed * 0.05
					local pos = targetHRP.Position
					local x = pos.X + orbitRadius * math.cos(angle)
					local y = pos.Y
					local z = pos.Z + orbitRadius * math.sin(angle)
					local goal = Vector3.new(x, y, z)
					local newPos = hrp.Position:Lerp(goal, 0.25)
					hrp.CFrame = CFrame.new(newPos, targetHRP.Position)
				end
			end
		end
		task.wait(0.03)
	end
end)
