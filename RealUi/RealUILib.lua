local RealUILib = {}
RealUILib.Version = "1.0 (Beta)"

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function createWindow(config)
	config = config or {}
	config.Title = config.Title or "Real UI"
	config.Size = config.Size or UDim2.new(0, 300, 0, 400)
	config.Position = config.Position or UDim2.new(0.5, -150, 0.5, -200)
	
	local Window = {}
	Window.Elements = {}
	Window.Config = config
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "RealUIWindow"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	MainFrame.BorderSizePixel = 1
	MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
	MainFrame.Size = config.Size
	MainFrame.Position = config.Position
	MainFrame.Parent = ScreenGui
	
	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	TitleBar.BorderSizePixel = 0
	TitleBar.Size = UDim2.new(1, 0, 0, 30)
	TitleBar.Parent = MainFrame
	
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "TitleLabel"
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	TitleLabel.TextSize = 13
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = config.Title
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Size = UDim2.new(1, -10, 1, 0)
	TitleLabel.Position = UDim2.new(0, 10, 0, 0)
	TitleLabel.Parent = TitleBar
	
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "ContentFrame"
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Size = UDim2.new(1, 0, 1, -30)
	ContentFrame.Position = UDim2.new(0, 0, 0, 30)
	ContentFrame.Parent = MainFrame
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = ContentFrame
	
	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingLeft = UDim.new(0, 8)
	UIPadding.PaddingRight = UDim.new(0, 8)
	UIPadding.PaddingTop = UDim.new(0, 8)
	UIPadding.PaddingBottom = UDim.new(0, 8)
	UIPadding.Parent = ContentFrame
	
	local dragging = false
	local dragStart = Vector2.new(0, 0)
	local frameStart = UDim2.new(0, 0, 0, 0)
	
	TitleBar.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = UserInputService:GetMouseLocation()
			frameStart = MainFrame.Position
		end
	end)
	
	TitleBar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.Mouse then
			local currentMouse = UserInputService:GetMouseLocation()
			local delta = currentMouse - dragStart
			MainFrame.Position = frameStart + UDim2.new(0, delta.X, 0, delta.Y)
		end
	end)
	
	function Window:AddButton(config)
		config = config or {}
		config.Label = config.Label or "Button"
		config.Callback = config.Callback or function() end
		
		local ButtonFrame = Instance.new("Frame")
		ButtonFrame.Name = "Button"
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		ButtonFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
		ButtonFrame.BorderSizePixel = 1
		ButtonFrame.Size = UDim2.new(1, 0, 0, 32)
		ButtonFrame.Parent = ContentFrame
		
		local ButtonLabel = Instance.new("TextLabel")
		ButtonLabel.BackgroundTransparency = 1
		ButtonLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		ButtonLabel.TextSize = 12
		ButtonLabel.Font = Enum.Font.Gotham
		ButtonLabel.Text = config.Label
		ButtonLabel.Size = UDim2.new(1, 0, 1, 0)
		ButtonLabel.Parent = ButtonFrame
		
		ButtonFrame.MouseButton1Click:Connect(config.Callback)
		
		ButtonFrame.MouseEnter:Connect(function()
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		end)
		
		ButtonFrame.MouseLeave:Connect(function()
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		end)
		
		return ButtonFrame
	end
	
	function Window:AddToggle(config)
		config = config or {}
		config.Label = config.Label or "Toggle"
		config.Default = config.Default or false
		config.Callback = config.Callback or function() end
		
		local state = config.Default
		
		local ToggleContainer = Instance.new("Frame")
		ToggleContainer.Name = "Toggle"
		ToggleContainer.BackgroundTransparency = 1
		ToggleContainer.Size = UDim2.new(1, 0, 0, 28)
		ToggleContainer.Parent = ContentFrame
		
		local ToggleLabel = Instance.new("TextLabel")
		ToggleLabel.BackgroundTransparency = 1
		ToggleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		ToggleLabel.TextSize = 12
		ToggleLabel.Font = Enum.Font.Gotham
		ToggleLabel.Text = config.Label
		ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
		ToggleLabel.Size = UDim2.new(1, -40, 1, 0)
		ToggleLabel.Parent = ToggleContainer
		
		local ToggleButton = Instance.new("Frame")
		ToggleButton.Name = "ToggleButton"
		ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(50, 50, 50)
		ToggleButton.BorderColor3 = Color3.fromRGB(70, 70, 70)
		ToggleButton.BorderSizePixel = 1
		ToggleButton.Size = UDim2.new(0, 36, 0, 18)
		ToggleButton.Position = UDim2.new(1, -40, 0.5, -9)
		ToggleButton.Parent = ToggleContainer
		
		local ToggleCircle = Instance.new("Frame")
		ToggleCircle.Name = "Circle"
		ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleCircle.BorderSizePixel = 0
		ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
		ToggleCircle.Position = state and UDim2.new(0, 20, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
		ToggleCircle.Parent = ToggleButton
		
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = ToggleButton
		
		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(0, 7)
		CircleCorner.Parent = ToggleCircle
		
		local function toggle()
			state = not state
			config.Callback(state)
			
			ToggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(50, 50, 50)
			
			local tween = game:GetService("TweenService"):Create(
				ToggleCircle,
				TweenInfo.new(0.2),
				{Position = state and UDim2.new(0, 20, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}
			)
			tween:Play()
		end
		
		ToggleButton.MouseButton1Click:Connect(toggle)
		
		return ToggleContainer
	end
	
	function Window:AddSlider(config)
		config = config or {}
		config.Label = config.Label or "Slider"
		config.Min = config.Min or 0
		config.Max = config.Max or 100
		config.Default = config.Default or config.Min
		config.Increment = config.Increment or 1
		config.Callback = config.Callback or function() end
		
		local currentValue = config.Default
		
		local SliderContainer = Instance.new("Frame")
		SliderContainer.Name = "Slider"
		SliderContainer.BackgroundTransparency = 1
		SliderContainer.Size = UDim2.new(1, 0, 0, 45)
		SliderContainer.Parent = ContentFrame
		
		local SliderLabel = Instance.new("TextLabel")
		SliderLabel.BackgroundTransparency = 1
		SliderLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		SliderLabel.TextSize = 12
		SliderLabel.Font = Enum.Font.Gotham
		SliderLabel.Text = config.Label
		SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
		SliderLabel.Size = UDim2.new(1, 0, 0, 15)
		SliderLabel.Parent = SliderContainer
		
		local ValueLabel = Instance.new("TextLabel")
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
		ValueLabel.TextSize = 11
		ValueLabel.Font = Enum.Font.Gotham
		ValueLabel.Text = tostring(math.floor(currentValue))
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		ValueLabel.Size = UDim2.new(1, 0, 0, 15)
		ValueLabel.Parent = SliderContainer
		
		local SliderBackground = Instance.new("Frame")
		SliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		SliderBackground.BorderColor3 = Color3.fromRGB(70, 70, 70)
		SliderBackground.BorderSizePixel = 1
		SliderBackground.Size = UDim2.new(1, 0, 0, 6)
		SliderBackground.Position = UDim2.new(0, 0, 0, 20)
		SliderBackground.Parent = SliderContainer
		
		local SliderFill = Instance.new("Frame")
		SliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
		SliderFill.BorderSizePixel = 0
		SliderFill.Size = UDim2.new((currentValue - config.Min) / (config.Max - config.Min), 0, 1, 0)
		SliderFill.Parent = SliderBackground
		
		local SliderButton = Instance.new("Frame")
		SliderButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
		SliderButton.BorderColor3 = Color3.fromRGB(70, 70, 70)
		SliderButton.BorderSizePixel = 1
		SliderButton.Size = UDim2.new(0, 12, 0, 18)
		SliderButton.Position = UDim2.new((currentValue - config.Min) / (config.Max - config.Min), -6, 0, -6)
		SliderButton.Parent = SliderBackground
		
		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 2)
		BtnCorner.Parent = SliderButton
		
		local draggingSlider = false
		
		local function updateSlider(input)
			local position = (input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X
			position = math.clamp(position, 0, 1)
			
			local value = config.Min + (position * (config.Max - config.Min))
			value = math.floor(value / config.Increment + 0.5) * config.Increment
			value = math.clamp(value, config.Min, config.Max)
			
			currentValue = value
			config.Callback(value)
			
			local fillSize = (value - config.Min) / (config.Max - config.Min)
			SliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
			SliderButton.Position = UDim2.new(fillSize, -6, 0, -6)
			ValueLabel.Text = tostring(math.floor(value))
		end
		
		SliderButton.MouseButton1Down:Connect(function()
			draggingSlider = true
		end)
		
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				draggingSlider = false
			end
		end)
		
		SliderBackground.MouseButton1Click:Connect(function(x, y)
			updateSlider({Position = UserInputService:GetMouseLocation()})
		end)
		
		UserInputService.InputChanged:Connect(function(input)
			if draggingSlider and input.UserInputType == Enum.UserInputType.Mouse then
				updateSlider({Position = UserInputService:GetMouseLocation()})
			end
		end)
		
		return SliderContainer
	end
	
	function Window:AddLabel(config)
		config = config or {}
		config.Text = config.Text or "Label"
		
		local LabelFrame = Instance.new("TextLabel")
		LabelFrame.Name = "Label"
		LabelFrame.BackgroundTransparency = 1
		LabelFrame.TextColor3 = Color3.fromRGB(150, 150, 150)
		LabelFrame.TextSize = 11
		LabelFrame.Font = Enum.Font.Gotham
		LabelFrame.Text = config.Text
		LabelFrame.TextWrapped = true
		LabelFrame.TextXAlignment = Enum.TextXAlignment.Left
		LabelFrame.Size = UDim2.new(1, 0, 0, 20)
		LabelFrame.Parent = ContentFrame
		
		return LabelFrame
	end
	
	function Window:AddDivider()
		local Divider = Instance.new("Frame")
		Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Divider.BorderSizePixel = 0
		Divider.Size = UDim2.new(1, 0, 0, 1)
		Divider.Parent = ContentFrame
		
		return Divider
	end
	
	function Window:Close()
		ScreenGui:Destroy()
	end
	
	return Window
end

function RealUILib:CreateWindow(config)
	return createWindow(config)
end

return RealUILib
