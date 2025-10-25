local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded
local root = char.HumanoidRootPart
local humanoid = char.Humanoid
local cam = workspace.CurrentCamera
local run = game:GetService("RunService")
local tool = Instance.new("Tool")
local vel
local cf
local dir
local direction
local event

tool.Name = "Siwo swim tool"
tool.RequiresHandle = false
tool.Parent = plr.Backpack
 
local speed = 17.5
 
tool.Equipped:Connect(function()
    vel = Instance.new("BodyVelocity")
    vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    vel.P = 1000000
    vel.Parent = root
    humanoid:SetStateEnabled("GettingUp", false)
    humanoid:ChangeState("Swimming")
    event = run.Heartbeat:Connect(function()
        cf = cam.CFrame.Rotation
        dir = cf:VectorToObjectSpace(humanoid.MoveDirection * speed)
        if dir.Magnitude == 0 then
            direction = Vector3.new(0,0,0)
        else
            direction = cf:VectorToWorldSpace(Vector3.new(dir.X, 0, dir.Z).Unit * dir.Magnitude)
        end
        vel.Velocity = direction
        humanoid:ChangeState("Swimming")
    end)
end)
 
tool.Unequipped:Connect(function()
    event:Disconnect()
    vel:Destroy()
    humanoid:SetStateEnabled("GettingUp", true)
end)
