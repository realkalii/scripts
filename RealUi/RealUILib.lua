local RealUi = {}
RealUi.__index = RealUi

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function RealUi.new()
	local self = setmetatable({}, RealUi)
	
	self.screenGui = Instance.new("ScreenGui")
	self.screenGui.Name = "RealUiGui"
	self.screenGui.ResetOnSpawn = false
	self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self.screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	self.mainWindow = Instance.new("Frame")
	self.mainWindow.Name = "MainWindow"
	self.mainWindow.Size = UDim2.new(0, 300, 0, 400)
	self.mainWindow.Position = UDim2.new(0.5, -150, 0.5, -200)
	self.mainWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	self.mainWindow.BorderSizePixel = 0
	self.mainWindow.Parent = self.screenGui
	
	local windowCorner = Instance.new("UICorner")
	windowCorner.CornerRadius = UDim.new(0, 6)
	windowCorner.Parent = self.mainWindow
	
	local windowPadding = Instance.new("UIPadding")
	windowPadding.PaddingLeft = UDim.new(0, 10)
	windowPadding.PaddingRight = UDim.new(0, 10)
	windowPadding.PaddingTop = UDim.new(0, 10)
	windowPadding.PaddingBottom = UDim.new(0, 10)
	windowPadding.Parent = self.mainWindow
	
	self.titleBar = Instance.new("Frame")
	self.titleBar.Name = "TitleBar"
	self.titleBar.Size = UDim2.new(1, 0, 0, 35)
	self.titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	self.titleBar.BorderSizePixel = 0
	self.titleBar.Parent = self.mainWindow
	
	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 4)
	titleCorner.Parent = self.titleBar
	
	self.titleLabel = Instance.new("TextLabel")
	self.titleLabel.Name = "TitleLabel"
	self.titleLabel.Size = UDim2.new(1, -70, 1, 0)
	self.titleLabel.BackgroundTransparency = 1
	self.titleLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
	self.titleLabel.TextSize = 14
	self.titleLabel.Font = Enum.Font.GothamBold
	self.titleLabel.Text = "RealUi"
	self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	self.titleLabel.Parent = self.titleBar
	
	self.minimizeBtn = Instance.new("TextButton")
	self.minimizeBtn.Name = "MinimizeBtn"
	self.minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
	self.minimizeBtn.Position = UDim2.new(1, -65, 0, 2)
	self.minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	self.minimizeBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
	self.minimizeBtn.TextSize = 12
	self.minimizeBtn.Font = Enum.Font.Gotham
	self.minimizeBtn.Text = "-"
	self.minimizeBtn.BorderSizePixel = 0
	self.minimizeBtn.Parent = self.titleBar
	
	local minimizeCorner = Instance.new("UICorner")
	minimizeCorner.CornerRadius = UDim.new(0, 3)
	minimizeCorner.Parent = self.minimizeBtn
	
	self.closeBtn = Instance.new("TextButton")
	self.closeBtn.Name = "CloseBtn"
	self.closeBtn.Size = UDim2.new(0, 30, 0, 30)
	self.closeBtn.Position = UDim2.new(1, -30, 0, 2)
	self.closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	self.closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.closeBtn.TextSize = 12
	self.closeBtn.Font = Enum.Font.Gotham
	self.closeBtn.Text = "Ã—"
	self.closeBtn.BorderSizePixel = 0
	self.closeBtn.Parent = self.titleBar
	
	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 3)
	closeCorner.Parent = self.closeBtn
	
	self.contentFrame = Instance.new("Frame")
	self.contentFrame.Name = "ContentFrame"
	self.contentFrame.Size = UDim2.new(1, 0, 1, -85)
	self.contentFrame.Position = UDim2.new(0, 0, 0, 40)
	self.contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	self.contentFrame.BorderSizePixel = 0
	self.contentFrame.Parent = self.mainWindow
	
	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = UDim.new(0, 4)
	contentCorner.Parent = self.contentFrame
	
	local contentPadding = Instance.new("UIPadding")
	contentPadding.PaddingLeft = UDim.new(0, 10)
	contentPadding.PaddingRight = UDim.new(0, 10)
	contentPadding.PaddingTop = UDim.new(0, 10)
	contentPadding.PaddingBottom = UDim.new(0, 10)
	contentPadding.Parent = self.contentFrame
	
	local contentLayout = Instance.new("UIListLayout")
	contentLayout.Padding = UDim.new(0, 8)
	contentLayout.Parent = self.contentFrame
	
	self.tabBar = Instance.new("Frame")
	self.tabBar.Name = "TabBar"
	self.tabBar.Size = UDim2.new(1, 0, 0, 40)
	self.tabBar.Position = UDim2.new(0, 0, 1, -45)
	self.tabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	self.tabBar.BorderSizePixel = 0
	self.tabBar.Parent = self.mainWindow
	
	local tabCorner = Instance.new("UICorner")
	tabCorner.CornerRadius = UDim.new(0, 4)
	tabCorner.Parent = self.tabBar
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.FillDirection = Enum.FillDirection.Horizontal
	tabLayout.Padding = UDim.new(0, 5)
	tabLayout.Parent = self.tabBar
	
	local tabPadding = Instance.new("UIPadding")
	tabPadding.PaddingLeft = UDim.new(0, 5)
	tabPadding.PaddingRight = UDim.new(0, 5)
	tabPadding.PaddingTop = UDim.new(0, 5)
	tabPadding.PaddingBottom = UDim.new(0, 5)
	tabPadding.Parent = self.tabBar
	
	self.floatingBtn = Instance.new("TextButton")
	self.floatingBtn.Name = "FloatingBtn"
	self.floatingBtn.Size = UDim2.new(0, 50, 0, 50)
	self.floatingBtn.Position = UDim2.new(1, -70, 1, -70)
	self.floatingBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
	self.floatingBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	self.floatingBtn.TextSize = 14
	self.floatingBtn.Font = Enum.Font.GothamBold
	self.floatingBtn.Text = "UI"
	self.floatingBtn.BorderSizePixel = 0
	self.floatingBtn.Parent = self.screenGui
	
	local floatingCorner = Instance.new("UICorner")
	floatingCorner.CornerRadius = UDim.new(0, 25)
	floatingCorner.Parent = self.floatingBtn
	
	self.tabs = {}
	self.currentTab = nil
	self.isMinimized = false
	self.windowOpen = true
	
	self.closeBtn.MouseButton1Click:Connect(function()
		self:ToggleWindow()
	end)
	
	self.minimizeBtn.MouseButton1Click:Connect(function()
		self:ToggleMinimize()
	end)
	
	self.floatingBtn.MouseButton1Click:Connect(function()
		self:ToggleWindow()
	end)
	
	return self
end

function RealUi:CreateTab(tabName)
	local tabButton = Instance.new("TextButton")
	tabButton.Name = tabName .. "Tab"
	tabButton.Size = UDim2.new(0, 80, 1, 0)
	tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tabButton.TextColor3 = Color3.fromRGB(100, 180, 255)
	tabButton.TextSize = 11
	tabButton.Font = Enum.Font.Gotham
	tabButton.Text = tabName
	tabButton.BorderSizePixel = 0
	tabButton.Parent = self.tabBar
	
	local tabCorner = Instance.new("UICorner")
	tabCorner.CornerRadius = UDim.new(0, 3)
	tabCorner.Parent = tabButton
	
	local tabContent = Instance.new("Frame")
	tabContent.Name = tabName .. "Content"
	tabContent.Size = UDim2.new(1, 0, 1, 0)
	tabContent.BackgroundTransparency = 1
	tabContent.BorderSizePixel = 0
	tabContent.Parent = self.contentFrame
	
	local tabContentLayout = Instance.new("UIListLayout")
	tabContentLayout.Padding = UDim.new(0, 8)
	tabContentLayout.Parent = tabContent
	
	if not self.currentTab then
		self.currentTab = tabName
	else
		tabContent.Visible = false
	end
	
	tabButton.MouseButton1Click:Connect(function()
		for _, frame in ipairs(self.contentFrame:GetChildren()) do
			if frame:IsA("Frame") and frame ~= tabContent then
				frame.Visible = false
			end
		end
		tabContent.Visible = true
		self.currentTab = tabName
		
		for _, btn in ipairs(self.tabBar:GetChildren()) do
			if btn:IsA("TextButton") then
				if btn == tabButton then
					btn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
					btn.TextColor3 = Color3.fromRGB(0, 0, 0)
				else
					btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					btn.TextColor3 = Color3.fromRGB(100, 180, 255)
				end
			end
		end
	end)
	
	self.tabs[tabName] = {
		button = tabButton,
		content = tabContent
	}
	
	return tabContent
end

function RealUi:CreateToggle(parent, label)
	local container = Instance.new("Frame")
	container.Name = label .. "Container"
	container.Size = UDim2.new(1, 0, 0, 30)
	container.BackgroundTransparency = 1
	container.BorderSizePixel = 0
	container.Parent = parent
	
	local labelWidget = Instance.new("TextLabel")
	labelWidget.Name = "Label"
	labelWidget.Size = UDim2.new(1, -45, 1, 0)
	labelWidget.BackgroundTransparency = 1
	labelWidget.TextColor3 = Color3.fromRGB(100, 180, 255)
	labelWidget.TextSize = 12
	labelWidget.Font = Enum.Font.Gotham
	labelWidget.Text = label
	labelWidget.TextXAlignment = Enum.TextXAlignment.Left
	labelWidget.Parent = container
	
	local toggleButton = Instance.new("TextButton")
	toggleButton.Name = "ToggleButton"
	toggleButton.Size = UDim2.new(0, 40, 0, 20)
	toggleButton.Position = UDim2.new(1, -40, 0.5, -10)
	toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	toggleButton.TextSize = 0
	toggleButton.BorderSizePixel = 0
	toggleButton.Parent = container
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 10)
	toggleCorner.Parent = toggleButton
	
	local toggleCircle = Instance.new("Frame")
	toggleCircle.Name = "Circle"
	toggleCircle.Size = UDim2.new(0, 16, 0, 16)
	toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	toggleCircle.BorderSizePixel = 0
	toggleCircle.Parent = toggleButton
	
	local circleCorner = Instance.new("UICorner")
	circleCorner.CornerRadius = UDim.new(0, 8)
	circleCorner.Parent = toggleCircle
	
	local toggleState = false
	
	toggleButton.MouseButton1Click:Connect(function()
		toggleState = not toggleState
		
		if toggleState then
			toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
			toggleCircle.Position = UDim2.new(0, 22, 0.5, -8)
		else
			toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
		end
	end)
	
	return {
		container = container,
		button = toggleButton,
		getValue = function() return toggleState end,
		setValue = function(value)
			toggleState = value
			if toggleState then
				toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
				toggleCircle.Position = UDim2.new(0, 22, 0.5, -8)
			else
				toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
			end
		end
	}
end

function RealUi:CreateSlider(parent, label, minValue, maxValue, defaultValue)
	local container = Instance.new("Frame")
	container.Name = label .. "Container"
	container.Size = UDim2.new(1, 0, 0, 50)
	container.BackgroundTransparency = 1
	container.BorderSizePixel = 0
	container.Parent = parent
	
	local labelWidget = Instance.new("TextLabel")
	labelWidget.Name = "Label"
	labelWidget.Size = UDim2.new(1, 0, 0, 15)
	labelWidget.BackgroundTransparency = 1
	labelWidget.TextColor3 = Color3.fromRGB(100, 180, 255)
	labelWidget.TextSize = 12
	labelWidget.Font = Enum.Font.Gotham
	labelWidget.Text = label .. ": " .. tostring(defaultValue or minValue)
	labelWidget.TextXAlignment = Enum.TextXAlignment.Left
	labelWidget.Parent = container
	
	local sliderBackground = Instance.new("Frame")
	sliderBackground.Name = "SliderBg"
	sliderBackground.Size = UDim2.new(1, 0, 0, 8)
	sliderBackground.Position = UDim2.new(0, 0, 0, 20)
	sliderBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	sliderBackground.BorderSizePixel = 0
	sliderBackground.Parent = container
	
	local sliderCorner = Instance.new("UICorner")
	sliderCorner.CornerRadius = UDim.new(0, 4)
	sliderCorner.Parent = sliderBackground
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Name = "SliderFill"
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBackground
	
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = sliderFill
	
	local sliderButton = Instance.new("TextButton")
	sliderButton.Name = "SliderButton"
	sliderButton.Size = UDim2.new(0, 16, 0, 16)
	sliderButton.Position = UDim2.new(0, -8, 0.5, -8)
	sliderButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
	sliderButton.TextSize = 0
	sliderButton.BorderSizePixel = 0
	sliderButton.Parent = sliderBackground
	
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 8)
	buttonCorner.Parent = sliderButton
	
	local currentValue = defaultValue or minValue
	
	local function updateSlider(input)
		local mousePos = input.Position.X
		local bgPos = sliderBackground.AbsolutePosition.X
		local bgSize = sliderBackground.AbsoluteSize.X
		
		local relativePos = math.max(0, math.min(mousePos - bgPos, bgSize))
		local percentage = relativePos / bgSize
		
		currentValue = minValue + (maxValue - minValue) * percentage
		currentValue = math.floor(currentValue * 100) / 100
		
		sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		sliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
		labelWidget.Text = label .. ": " .. tostring(currentValue)
	end
	
	local dragging = false
	
	sliderButton.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)
	
	sliderButton.InputEnded:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			updateSlider(input)
		end
	end)
	
	sliderBackground.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			updateSlider(input)
			dragging = true
		end
	end)
	
	local percentage = (defaultValue - minValue) / (maxValue - minValue)
	sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
	sliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
	
	return {
		container = container,
		getValue = function() return currentValue end,
		setValue = function(value)
			currentValue = math.max(minValue, math.min(maxValue, value))
			local percentage = (currentValue - minValue) / (maxValue - minValue)
			sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			sliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
			labelWidget.Text = label .. ": " .. tostring(currentValue)
		end
	}
end

function RealUi:CreateButton(parent, label, callback)
	local button = Instance.new("TextButton")
	button.Name = label .. "Button"
	button.Size = UDim2.new(1, 0, 0, 35)
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.fromRGB(100, 180, 255)
	button.TextSize = 12
	button.Font = Enum.Font.GothamBold
	button.Text = label
	button.BorderSizePixel = 0
	button.Parent = parent
	
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 4)
	buttonCorner.Parent = button
	
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
	
	button.MouseButton1Click:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(80, 140, 200)
		if callback then
			callback()
		end
		wait(0.1)
		button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	
	return button
end

function RealUi:ToggleWindow()
	self.windowOpen = not self.windowOpen
	self.mainWindow.Visible = self.windowOpen
end

function RealUi:ToggleMinimize()
	self.isMinimized = not self.isMinimized
	
	if self.isMinimized then
		self.contentFrame.Visible = false
		self.tabBar.Visible = false
		self.mainWindow.Size = UDim2.new(0, 300, 0, 45)
		self.minimizeBtn.Text = "+"
	else
		self.contentFrame.Visible = true
		self.tabBar.Visible = true
		self.mainWindow.Size = UDim2.new(0, 300, 0, 400)
		self.minimizeBtn.Text = "-"
	end
end

function RealUi:SetTitle(title)
	self.titleLabel.Text = title
end

function RealUi:Destroy()
	self.screenGui:Destroy()
end

return RealUi
