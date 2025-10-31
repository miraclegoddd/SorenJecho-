--// 🕶️ Siwo Emotes GUI with Key System
-- Made by Siwo | Key System Integration by GPT-5

local REQUIRED_KEY = "SiwoKey2025" -- change this to your own key
local player = game.Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- 🌑 Key System GUI
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "SiwoKeyUI"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Parent = keyGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(40, 40, 40)
stroke.Parent = frame

local label = Instance.new("TextLabel")
label.Text = "🔒 Enter Access Key"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, 0, 0.3, 0)
label.Parent = frame

local box = Instance.new("TextBox")
box.PlaceholderText = "Type your key..."
box.Text = ""
box.ClearTextOnFocus = false
box.TextScaled = true
box.TextColor3 = Color3.new(1, 1, 1)
box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
box.BorderSizePixel = 0
box.Font = Enum.Font.Gotham
box.Size = UDim2.new(0.9, 0, 0.3, 0)
box.Position = UDim2.new(0.05, 0, 0.4, 0)
box.Parent = frame
local bcorner = Instance.new("UICorner", box)
bcorner.CornerRadius = UDim.new(0, 8)

local button = Instance.new("TextButton")
button.Text = "Unlock"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.BorderSizePixel = 0
button.Size = UDim2.new(0.9, 0, 0.25, 0)
button.Position = UDim2.new(0.05, 0, 0.75, 0)
button.Parent = frame
local ccorner = Instance.new("UICorner", button)
ccorner.CornerRadius = UDim.new(0, 8)

local AccessGranted = false
button.MouseButton1Click:Connect(function()
	if box.Text == REQUIRED_KEY then
		AccessGranted = true
		keyGui:Destroy()
		StarterGui:SetCore("SendNotification", {Title="Access Granted", Text="Welcome, Siwo!"})
	else
		label.Text = "❌ Wrong Key"
		task.wait(1)
		label.Text = "🔒 Enter Access Key"
		box.Text = ""
	end
end)

repeat task.wait() until AccessGranted

-- 🌟 When key is correct, load your emote menu
loadstring(game:HttpGet("https://raw.githubusercontent.com/miraclegoddd/SorenJecho-/refs/heads/main/sorenjechoemoteV2.lua"))()
