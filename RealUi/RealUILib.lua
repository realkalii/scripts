local RealUILib = {}

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RealUILib"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TitleBar.BorderSizePixel = 1
TitleBar.BorderColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -25, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ZETA Test Hub"
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 25, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -50, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 25, 1, 0)
CloseBtn.Position = UDim2.new(1, -25, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "x"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local TabsContainer = Instance.new("Frame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Size = UDim2.new(1, 0, 0, 25)
TabsContainer.Position = UDim2.new(0, 0, 1, 0)
TabsContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TabsContainer.BorderSizePixel = 1
TabsContainer.BorderColor3 = Color3.fromRGB(30, 30, 30)
TabsContainer.Parent = ContentFrame

local function CreateTabButton(Name, Callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 100, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = Name
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.Font = Enum.Font.SourceSans
    Btn.TextSize = 12
    Btn.Parent = TabsContainer

    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("Frame") and child.Name ~= "TabsContainer" then
                child.Visible = false
            end
        end
        Callback()
    end)
    return Btn
end

local function AddTab(Name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = Name .. "Tab"
    TabFrame.Size = UDim2.new(1, 0, 1, -25)
    TabFrame.Position = UDim2.new(0, 0, 0, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.ScrollBarThickness = 5
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    TabFrame.Parent = ContentFrame
    TabFrame.Visible = false
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabFrame
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.Parent = TabFrame

    return TabFrame
end

function RealUILib.new()
    local self = {}
    
    function self:SetTitle(Title)
        TitleLabel.Text = Title
    end
    
    function self:CreateTab(Name)
        local TabContainer = AddTab(Name)
        
        local TabBtn = CreateTabButton(Name, function()
            TabContainer.Visible = true
        end)
        
        return TabContainer
    end
    
    function self:CreateButton(Parent, Text, Callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 25)
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Btn.BorderSizePixel = 1
        Btn.BorderColor3 = Color3.fromRGB(35, 35, 35)
        Btn.Text = "  " .. Text
        Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        Btn.Font = Enum.Font.SourceSans
        Btn.TextSize = 13
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Btn.Parent = Parent
        
        Btn.MouseButton1Click:Connect(Callback)
    end
    
    function self:CreateToggle(Parent, Text)
        local ToggleContainer = Instance.new("Frame")
        ToggleContainer.Size = UDim2.new(1, -10, 0, 25)
        ToggleContainer.BackgroundTransparency = 1
        ToggleContainer.Parent = Parent
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -30, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = "  " .. Text
        Label.TextColor3 = Color3.fromRGB(220, 220, 220)
        Label.Font = Enum.Font.SourceSans
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleContainer
        
        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, 25, 0, 20)
        ToggleBtn.Position = UDim2.new(1, -25, 0.5, -10)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ToggleBtn.BorderSizePixel = 1
        ToggleBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
        ToggleBtn.Text = ""
        ToggleBtn.Parent = ToggleContainer
        
        local ToggleValue = false
        ToggleBtn.MouseButton1Click:Connect(function()
            ToggleValue = not ToggleValue
            if ToggleValue then
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(85, 140, 255)
            else
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
        end)
    end
    
    function self:CreateSlider(Parent, Text, Min, Max, Default)
        local SliderContainer = Instance.new("Frame")
        SliderContainer.Size = UDim2.new(1, -10, 0, 35)
        SliderContainer.BackgroundTransparency = 1
        SliderContainer.Parent = Parent
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -30, 0, 15)
        Label.BackgroundTransparency = 1
        Label.Text = "  " .. Text
        Label.TextColor3 = Color3.fromRGB(220, 220, 220)
        Label.Font = Enum.Font.SourceSans
        Label.TextSize = 13
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderContainer
        
        local SliderBar = Instance.new("Frame")
        SliderBar.Size = UDim2.new(1, -10, 0, 6)
        SliderBar.Position = UDim2.new(0, 5, 0, 20)
        SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        SliderBar.BorderSizePixel = 0
        SliderBar.Parent = SliderContainer
        
        local FillBar = Instance.new("Frame")
        FillBar.Size = UDim2.new(0.5, 0, 1, 0)
        FillBar.BackgroundColor3 = Color3.fromRGB(85, 140, 255)
        FillBar.BorderSizePixel = 0
        FillBar.Parent = SliderBar
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Size = UDim2.new(0, 30, 0, 15)
        ValueLabel.Position = UDim2.new(1, -30, 0, 0)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(math.floor(Default))
        ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        ValueLabel.Font = Enum.Font.SourceSans
        ValueLabel.TextSize = 12
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValueLabel.Parent = SliderContainer
        
        local dragging = false
        SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        SliderBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        local function UpdateSlider(x)
            local size = math.clamp((x - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            FillBar.Size = UDim2.new(size, 0, 1, 0)
            local val = Min + ((Max - Min) * size)
            ValueLabel.Text = tostring(math.floor(val))
        end
        
        SliderBar.MouseMove:Connect(function(x)
            if dragging then
                UpdateSlider(x.X)
            end
        end)
    end
    
    function self:Destroy()
        ScreenGui:Destroy()
    end
    
    function self:ToggleMinimize()
        MainFrame.Visible = not MainFrame.Visible
    end
    
    function self:ToggleWindow()
        MainFrame.Visible = true
    end
    
    CloseBtn.MouseButton1Click:Connect(function() self:Destroy() end)
    MinimizeBtn.MouseButton1Click:Connect(function() self:ToggleMinimize() end)
    
    return self
end

return RealUILib
