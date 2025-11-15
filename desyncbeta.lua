local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("TthanhhubV3") then
    playerGui.TthanhhubV3:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "TthanhhubV3"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 120)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.002) % 1
        main.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        RunService.RenderStepped:Wait()
    end
end)

local dragging = false
local dragInput, startPos, startMousePos

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startMousePos = input.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - startMousePos
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local title = Instance.new("TextLabel")
title.Text = "Tthanhhub V3"
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Parent = main

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -20, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 40)
btn.Text = "Desync"
btn.TextScaled = true
btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main

local btnCorner = Instance.new("UICorner", btn)
btnCorner.CornerRadius = UDim.new(0, 10)

local running = false
local killConnection = nil

local function StopScripts()
    running = false
    if killConnection then
        killConnection:Disconnect()
        killConnection = nil
    end
end

btn.MouseButton1Click:Connect(function()
    if not running then
        running = true

        task.spawn(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/SadoXTeam/data/refs/heads/main/a"))()
            task.wait(0.7)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/SadoXTeam/data/refs/heads/main/desyncdata"))()
        end)

        killConnection = player.CharacterAdded:Connect(function()
            StopScripts()
        end)
    end
end)
