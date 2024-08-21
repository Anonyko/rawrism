if game.CoreGui:FindFirstChild("AutoFarmUI") then game.CoreGui:FindFirstChild("AutoFarmUI"):Destroy() end

local UIMods = {}


local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "AutoFarmUI"
ScreenGui.Parent = game.CoreGui

-- MainFrame properties
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundTransparency = 0
MainFrame.Size = UDim2.new(0, 300, 0, 175)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)

local mainFrameCorner = UICorner:Clone()
mainFrameCorner.Parent = MainFrame

-- 	Color properties
local gradient = Instance.new("UIGradient")
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(219, 219, 219)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})
gradient.Parent = MainFrame

-- TitleLabel properties
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(0, 200, 0, 30)
TitleLabel.Position = UDim2.new(0, 0.5, 0, 10)
TitleLabel.Text = "Farming Stats"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextScaled = true
TitleLabel.TextColor3 = Color3.new(1, 1, 1)

-- InfoLabel properties
InfoLabel.Name = "InfoLabel"
InfoLabel.Parent = MainFrame
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(0, 200, 0, 20)
InfoLabel.Position = UDim2.new(0, 15, 0, 40)
InfoLabel.Text = "Samarium Project. | Beta"
InfoLabel.Font = Enum.Font.SciFi
InfoLabel.TextScaled = true
InfoLabel.TextColor3 = Color3.new(1, 1, 1)

local function setupSection(section, text, position, size, font)
	section.BackgroundTransparency = 1
	section.Size = size
	section.Position = position
	section.Text = text .. "Haven't Started Yet"
	section.TextScaled = false
	section.TextSize = 14
	section.TextWrapped = true
	section.TextColor3 = Color3.new(1, 1, 1)
	section.Font = font
	section.Parent = MainFrame

	local corner = UICorner:Clone()
	corner.Parent = section
end

-- Sections
local Sections = {
	Countdown = Instance.new("TextLabel"),
	TotalMoney = Instance.new("TextLabel"),
	TotalTime = Instance.new("TextLabel"),
	TotalEarnings = Instance.new("TextLabel"),
}

-- Setup sections
setupSection(Sections.Countdown, "Discord: ", UDim2.new(0, 0, 0, 70), UDim2.new(0, 200, 0, 40), Enum.Font.SourceSansBold)
setupSection(Sections.TotalMoney, "Current Balance: ", UDim2.new(0, 12, 0,90), UDim2.new(0, 200, 0, 40), Enum.Font.SourceSansBold)
setupSection(Sections.TotalTime, "Time Elapsed: ", UDim2.new(0, 5, 0, 110), UDim2.new(0, 200, 0, 40), Enum.Font.SourceSansBold)
setupSection(Sections.TotalEarnings, "Money Earned: ", UDim2.new(0, 7, 0, 130), UDim2.new(0, 200, 0, 40), Enum.Font.SourceSansBold)

-- Drag Function
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateInput(input)
	end
end)

function UIMods:updateCountdownText(newText)
	Sections.Countdown.Text = `Discord: discord.gg/{newText}`
end

function UIMods:updateTotalMoneyText(newText)
	Sections.TotalMoney.Text = "Current Balance: " .. newText
end

function UIMods:updateTotalTimeText(newText)
	Sections.TotalTime.Text = "Time Elapsed: " .. newText
end

function UIMods:updateTotalEarningsText(newText)
	Sections.TotalEarnings.Text = "Money Earned: " .. newText
end


return UIMods

-- Change text in here
--[[updateTeleportText("5 seconds")
updateDestinationText("New Location")
updateCountdownText("10")
updateTotalMoneyText("$1000")
updateTotalTimeText("2 hours")
updateTotalEarningsText("$2000")]]
