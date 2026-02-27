local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local pinned = false

-- GUI Setup
local s = Instance.new("ScreenGui", p.PlayerGui)
s.Name = "FlingGui"

local f = Instance.new("Frame", s)
f.Size = UDim2.new(0, 180, 0, 110)
f.Position = UDim2.new(0.5, -90, 0.8, -120)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.Active = true
f.Draggable = true 
Instance.new("UICorner", f)

-- Fling Button (Toggle)
local active = false
local b = Instance.new("TextButton", f)
b.Size = UDim2.new(0.9, 0, 0.4, 0)
b.Position = UDim2.new(0.05, 0, 0.1, 0)
b.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
b.Text = "START FLING"
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBold
Instance.new("UICorner", b)

-- Pin Button
local pin = Instance.new("TextButton", f)
pin.Size = UDim2.new(0.9, 0, 0.3, 0)
pin.Position = UDim2.new(0.05, 0, 0.55, 0)
pin.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
pin.Text = "📌 PIN: OFF"
pin.TextColor3 = Color3.new(1, 1, 1)
pin.Font = Enum.Font.GothamBold
Instance.new("UICorner", pin)

-- Toggle Pin
pin.MouseButton1Click:Connect(function()
	pinned = not pinned
	f.Draggable = not pinned
	pin.Text = pinned and "📌 PIN: ON" or "📌 PIN: OFF"
	pin.BackgroundColor3 = pinned and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(60, 60, 60)
end)

-- The "Forward" Fling Logic
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(0, 0, 0) -- Start off

b.MouseButton1Click:Connect(function()
	active = not active
	if active then
		bv.Parent = root
		bv.MaxForce = Vector3.new(1, 1, 1) * 1e6
		b.Text = "STOP FLING"
		b.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	else
		bv.MaxForce = Vector3.new(0, 0, 0)
		b.Text = "START FLING"
		b.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end
end)

-- Constant Forward Force
game:GetService("RunService").Heartbeat:Connect(function()
	if active then
		-- This makes you fly WHERE YOU ARE LOOKING!
		bv.Velocity = root.CFrame.LookVector * 150 + Vector3.new(0, 2, 0)
	end
end)
