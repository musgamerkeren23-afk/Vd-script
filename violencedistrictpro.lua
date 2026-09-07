local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

-- ══════════════════════════════
--         COLORS
-- ══════════════════════════════

local C_BG = Color3.fromRGB(12, 0, 0)
local C_SIDEBAR = Color3.fromRGB(18, 0, 0)
local C_CARD = Color3.fromRGB(22, 0, 0)
local C_RED = Color3.fromRGB(200, 0, 0)
local C_BRIGHTRED = Color3.fromRGB(255, 40, 40)
local C_DARKRED = Color3.fromRGB(80, 0, 0)
local C_TEXT = Color3.fromRGB(220, 220, 220)
local C_DIM = Color3.fromRGB(140, 140, 140)
local C_WHITE = Color3.fromRGB(255, 255, 255)
local C_GREEN = Color3.fromRGB(0, 200, 80)
local C_YELLOW = Color3.fromRGB(255, 200, 0)
local C_BORDER = Color3.fromRGB(60, 0, 0)

-- ══════════════════════════════
--         SETTINGS
-- ══════════════════════════════

local Settings = {
    -- Combat
    Aimbot = false,
    AimbotFOV = 100,
    AimbotSmooth = 0.2,
    AimbotPart = "Head",
    SilentAim = false,
    StrongLock = false,
    LockedTarget = nil,

    -- Visuals
    ESPPlayer = false,
    ESPGenerator = false,
    ESPHook = false,
    ESPGate = false,

    -- Movement
    Speed = false,
    SpeedValue = 16,
    JumpPower = false,
    JumpValue = 50,
    InfiniteJump = false,
    NoClip = false,

    -- Farm
    FakeScrap = false,
    FakeScrapValue = 1000,
    AutoFarm = false,

    -- Misc
    AntiAFK = false,
    FPSBoost = false,
}

-- ══════════════════════════════
--         MAIN GUI
-- ══════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VDProHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main container
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 580, 0, 420)
mainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
mainFrame.BackgroundColor3 = C_BG
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = C_RED
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Glow effect
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = C_RED
glow.ImageTransparency = 0.7
glow.ZIndex = 0
glow.Parent = mainFrame

-- ══════════════════════════════
--         TITLE BAR
-- ══════════════════════════════

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 46)
titleBar.BackgroundColor3 = C_SIDEBAR
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 10)
titleBarCorner.Parent = titleBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, C_SIDEBAR),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0))
})
titleGradient.Rotation = 90
titleGradient.Parent = titleBar

-- Logo/Icon
local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(0, 36, 0, 36)
logoLabel.Position = UDim2.new(0, 8, 0.5, -18)
logoLabel.BackgroundColor3 = C_RED
logoLabel.Text = "💀"
logoLabel.TextSize = 18
logoLabel.Font = Enum.Font.GothamBold
logoLabel.BorderSizePixel = 0
logoLabel.Parent = titleBar
Instance.new("UICorner", logoLabel).CornerRadius = UDim.new(0, 8)

-- Title text
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -120, 1, 0)
titleLabel.Position = UDim2.new(0, 52, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "H4ll0 W0rld | Violence District Pro"
titleLabel.TextColor3 = C_BRIGHTRED
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 100, 0, 16)
versionLabel.Position = UDim2.new(0, 52, 1, -18)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v2.1 | Survivor"
versionLabel.TextColor3 = C_DARKRED
versionLabel.TextSize = 10
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = titleBar

-- Close & Minimize buttons
local function makeTitleBtn(text, xOff, bgColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 28, 0, 28)
    btn.Position = UDim2.new(1, xOff, 0.5, -14)
    btn.BackgroundColor3 = bgColor
    btn.Text = text
    btn.TextColor3 = C_WHITE
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = titleBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local closeBtn = makeTitleBtn("✕", -36, Color3.fromRGB(180, 30, 30))
local minBtn = makeTitleBtn("—", -70, C_DARKRED)

-- Title separator
local titleSep = Instance.new("Frame")
titleSep.Size = UDim2.new(1, 0, 0, 1)
titleSep.Position = UDim2.new(0, 0, 1, 0)
titleSep.BackgroundColor3 = C_RED
titleSep.BackgroundTransparency = 0.5
titleSep.BorderSizePixel = 0
titleSep.Parent = titleBar

-- Flicker title effect
coroutine.wrap(function()
    while titleLabel and titleLabel.Parent do
        titleLabel.TextTransparency = 0.5
        task.wait(0.04)
        titleLabel.TextTransparency = 0
        task.wait(math.random(4, 9))
    end
end)()

-- ══════════════════════════════
--         SIDEBAR
-- ══════════════════════════════

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 130, 1, -46)
sidebar.Position = UDim2.new(0, 0, 0, 46)
sidebar.BackgroundColor3 = C_SIDEBAR
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarSep = Instance.new("Frame")
sidebarSep.Size = UDim2.new(0, 1, 1, 0)
sidebarSep.Position = UDim2.new(1, 0, 0, 0)
sidebarSep.BackgroundColor3 = C_RED
sidebarSep.BackgroundTransparency = 0.5
sidebarSep.BorderSizePixel = 0
sidebarSep.Parent = sidebar

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 2)
sidebarLayout.Parent = sidebar

local sidebarPad = Instance.new("UIPadding")
sidebarPad.PaddingTop = UDim.new(0, 8)
sidebarPad.PaddingLeft = UDim.new(0, 6)
sidebarPad.PaddingRight = UDim.new(0, 6)
sidebarPad.Parent = sidebar

-- ══════════════════════════════
--         CONTENT AREA
-- ══════════════════════════════

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -130, 1, -46)
contentArea.Position = UDim2.new(0, 130, 0, 46)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- ══════════════════════════════
--         TAB SYSTEM
-- ══════════════════════════════

local tabs = {}
local tabPages = {}
local activeTab = nil

local tabData = {
    {name = "Combat", icon = "⚔️", order = 1},
    {name = "Visuals", icon = "👁", order = 2},
    {name = "Movement", icon = "⚡", order = 3},
    {name = "Farm", icon = "💰", order = 4},
    {name = "Player", icon = "👤", order = 5},
    {name = "Misc", icon = "⚙️", order = 6},
}

local function makePage()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ScrollBarImageColor3 = C_RED
    scroll.Visible = false
    scroll.Parent = contentArea

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.Parent = scroll

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 16)
    end)

    return scroll
end

local function switchTab(name, btn)
    for _, page in pairs(tabPages) do page.Visible = false end
    tabPages[name].Visible = true

    if activeTab then
        activeTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        activeTab.BackgroundTransparency = 1
        local lbl = activeTab:FindFirstChildWhichIsA("TextLabel")
        if lbl then lbl.TextColor3 = C_DIM end
        local indicator = activeTab:FindFirstChild("Indicator")
        if indicator then indicator.Visible = false end
    end

    btn.BackgroundColor3 = C_CARD
    btn.BackgroundTransparency = 0
    local lbl = btn:FindFirstChildWhichIsA("TextLabel")
    if lbl then lbl.TextColor3 = C_BRIGHTRED end
    local indicator = btn:FindFirstChild("Indicator")
    if indicator then indicator.Visible = true end

    activeTab = btn
end

for _, data in ipairs(tabData) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = ""
    tabBtn.BorderSizePixel = 0
    tabBtn.LayoutOrder = data.order
    tabBtn.Parent = sidebar
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

    -- Active indicator
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 3, 0.7, 0)
    indicator.Position = UDim2.new(0, 0, 0.15, 0)
    indicator.BackgroundColor3 = C_BRIGHTRED
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = tabBtn
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 3)

    local tabIcon = Instance.new("TextLabel")
    tabIcon.Size = UDim2.new(0, 24, 1, 0)
    tabIcon.Position = UDim2.new(0, 10, 0, 0)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Text = data.icon
    tabIcon.TextSize = 14
    tabIcon.Font = Enum.Font.Gotham
    tabIcon.Parent = tabBtn

    local tabLbl = Instance.new("TextLabel")
    tabLbl.Size = UDim2.new(1, -36, 1, 0)
    tabLbl.Position = UDim2.new(0, 36, 0, 0)
    tabLbl.BackgroundTransparency = 1
    tabLbl.Text = data.name
    tabLbl.TextColor3 = C_DIM
    tabLbl.TextSize = 12
    tabLbl.Font = Enum.Font.GothamBold
    tabLbl.TextXAlignment = Enum.TextXAlignment.Left
    tabLbl.Parent = tabBtn

    tabBtn.MouseEnter:Connect(function()
        if tabBtn ~= activeTab then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.7, BackgroundColor3 = C_CARD}):Play()
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if tabBtn ~= activeTab then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
        end
    end)

    local page = makePage()
    tabs[data.name] = tabBtn
    tabPages[data.name] = page

    tabBtn.MouseButton1Click:Connect(function()
        switchTab(data.name, tabBtn)
    end)
end

-- ══════════════════════════════
--         UI COMPONENTS
-- ══════════════════════════════

local function makeCard(parent, order)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 46)
    card.BackgroundColor3 = C_CARD
    card.BorderSizePixel = 0
    card.LayoutOrder = order
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = C_BORDER
    stroke.Thickness = 1
    stroke.Parent = card

    return card
end

local function makeToggle(parent, text, desc, order, callback)
    local card = makeCard(parent, order)

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 6, 0.7, 0)
    icon.Position = UDim2.new(0, 0, 0.15, 0)
    icon.BackgroundColor3 = C_DARKRED
    icon.Text = ""
    icon.BorderSizePixel = 0
    icon.Parent = card
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 3)
    ic.Parent = icon

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.65, 0, 0, 20)
    lbl.Position = UDim2.new(0, 14, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C_TEXT
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(0.65, 0, 0, 16)
    descLbl.Position = UDim2.new(0, 14, 0, 26)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = desc or ""
    descLbl.TextColor3 = C_DIM
    descLbl.TextSize = 10
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = card

    local togBtn = Instance.new("TextButton")
    togBtn.Size = UDim2.new(0, 52, 0, 24)
    togBtn.Position = UDim2.new(1, -60, 0.5, -12)
    togBtn.BackgroundColor3 = C_DARKRED
    togBtn.Text = "OFF"
    togBtn.TextColor3 = Color3.fromRGB(180, 60, 60)
    togBtn.TextSize = 11
    togBtn.Font = Enum.Font.GothamBold
    togBtn.BorderSizePixel = 0
    togBtn.Parent = card
    Instance.new("UICorner", togBtn).CornerRadius = UDim.new(0, 6)

    local state = false
    togBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            togBtn.Text = "ON"
            togBtn.TextColor3 = C_GREEN
            TweenService:Create(togBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 60, 20)}):Play()
            TweenService:Create(icon, TweenInfo.new(0.2), {BackgroundColor3 = C_BRIGHTRED}):Play()
        else
            togBtn.Text = "OFF"
            togBtn.TextColor3 = Color3.fromRGB(180, 60, 60)
            TweenService:Create(togBtn, TweenInfo.new(0.2), {BackgroundColor3 = C_DARKRED}):Play()
            TweenService:Create(icon, TweenInfo.new(0.2), {BackgroundColor3 = C_DARKRED}):Play()
        end
        if callback then callback(state) end
    end)

    return card, togBtn
end

local function makeSlider(parent, text, minVal, maxVal, defaultVal, order, callback)
    local card = makeCard(parent, order)
    card.Size = UDim2.new(1, 0, 0, 58)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 0, 18)
    lbl.Position = UDim2.new(0, 14, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C_TEXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0.35, 0, 0, 18)
    valLbl.Position = UDim2.new(0.62, 0, 0, 6)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(defaultVal)
    valLbl.TextColor3 = C_BRIGHTRED
    valLbl.TextSize = 12
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = card

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -28, 0, 8)
    sliderBg.Position = UDim2.new(0, 14, 0, 32)
    sliderBg.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = card
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultVal-minVal)/(maxVal-minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = C_RED
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((defaultVal-minVal)/(maxVal-minVal), -7, 0.5, -7)
    knob.BackgroundColor3 = C_BRIGHTRED
    knob.BorderSizePixel = 0
    knob.Parent = sliderBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            local val = math.floor(minVal + (maxVal - minVal) * rel)
            sliderFill.Size = UDim2.new(rel, 0, 1, 0)
            knob.Position = UDim2.new(rel, -7, 0.5, -7)
            valLbl.Text = tostring(val)
            if callback then callback(val) end
        end
    end)

    return card
end

local function makeDropdown(parent, text, options, order, callback)
    local card = makeCard(parent, order)
    card.Size = UDim2.new(1, 0, 0, 46)
    card.ClipsDescendants = false

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C_TEXT
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0, 120, 0, 28)
    dropBtn.Position = UDim2.new(1, -128, 0.5, -14)
    dropBtn.BackgroundColor3 = C_DARKRED
    dropBtn.Text = options[1] .. " ▼"
    dropBtn.TextColor3 = C_TEXT
    dropBtn.TextSize = 11
    dropBtn.Font = Enum.Font.GothamBold
    dropBtn.BorderSizePixel = 0
    dropBtn.Parent = card
    Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 6)

    local dropList = Instance.new("Frame")
    dropList.Size = UDim2.new(0, 120, 0, #options * 28)
    dropList.Position = UDim2.new(1, -128, 1, 4)
    dropList.BackgroundColor3 = C_CARD
    dropList.BorderSizePixel = 0
    dropList.Visible = false
    dropList.ZIndex = 10
    dropList.Parent = card
    Instance.new("UICorner", dropList).CornerRadius = UDim.new(0, 6)

    local dropLayout = Instance.new("UIListLayout")
    dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dropLayout.Parent = dropList

    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 28)
        optBtn.BackgroundColor3 = C_CARD
        optBtn.Text = opt
        optBtn.TextColor3 = C_TEXT
        optBtn.TextSize = 11
        optBtn.Font = Enum.Font.Gotham
        optBtn.BorderSizePixel = 0
        optBtn.LayoutOrder = i
        optBtn.ZIndex = 11
        optBtn.Parent = dropList
        Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)

        optBtn.MouseButton1Click:Connect(function()
            dropBtn.Text = opt .. " ▼"
            dropList.Visible = false
            if callback then callback(opt) end
        end)

        optBtn.MouseEnter:Connect(function() optBtn.BackgroundColor3 = C_DARKRED end)
        optBtn.MouseLeave:Connect(function() optBtn.BackgroundColor3 = C_CARD end)
    end

    dropBtn.MouseButton1Click:Connect(function()
        dropList.Visible = not dropList.Visible
    end)

    return card
end

local function makeSectionHeader(parent, text, order)
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 24)
    header.BackgroundTransparency = 1
    header.Text = "  " .. text
    header.TextColor3 = C_RED
    header.TextSize = 11
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.LayoutOrder = order
    header.Parent = parent

    local line = Instance.new("Frame")
    line.Size = UDim2.new(0.3, 0, 0, 1)
    line.Position = UDim2.new(0.7, 0, 0.5, 0)
    line.BackgroundColor3 = C_DARKRED
    line.BorderSizePixel = 0
    line.Parent = header

    return header
end

local function makeActionBtn(parent, text, color, order, callback)
    local card = makeCard(parent, order)
    card.Size = UDim2.new(1, 0, 0, 40)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 28)
    btn.Position = UDim2.new(0, 8, 0.5, -14)
    btn.BackgroundColor3 = color or C_RED
    btn.Text = text
    btn.TextColor3 = C_WHITE
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = card
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.new(
                math.min((color or C_RED).R + 0.1, 1),
                math.min((color or C_RED).G + 0.1, 1),
                math.min((color or C_RED).B + 0.1, 1)
            )
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = color or C_RED}):Play()
    end)

    return card, btn
end

-- ══════════════════════════════
--     COMBAT TAB
-- ══════════════════════════════

local combatPage = tabPages["Combat"]

makeSectionHeader(combatPage, "AIMBOT", 1)

makeToggle(combatPage, "Aimbot", "Auto aim to nearest player", 2, function(state)
    Settings.Aimbot = state
end)

makeToggle(combatPage, "Silent Aim", "Invisible bullet redirect", 3, function(state)
    Settings.SilentAim = state
end)

makeToggle(combatPage, "Strong Lock", "Lock target permanently", 4, function(state)
    Settings.StrongLock = state
    if not state then Settings.LockedTarget = nil end
end)

makeSlider(combatPage, "FOV Radius", 20, 300, 100, 5, function(val)
    Settings.AimbotFOV = val
end)

makeSlider(combatPage, "Smoothness", 1, 20, 4, 6, function(val)
    Settings.AimbotSmooth = val / 20
end)

makeDropdown(combatPage, "Aim Part", {"Head", "HumanoidRootPart", "Torso"}, 7, function(val)
    Settings.AimbotPart = val
end)

-- FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Radius = Settings.AimbotFOV
fovCircle.Color = Color3.fromRGB(255, 40, 40)
fovCircle.Thickness = 1.5
fovCircle.Filled = false
fovCircle.Visible = false
fovCircle.NumSides = 64
fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

-- ══════════════════════════════
--     VISUALS TAB
-- ══════════════════════════════

local visualsPage = tabPages["Visuals"]

makeSectionHeader(visualsPage, "ESP", 1)

makeToggle(visualsPage, "Player ESP", "Show all players with box + info", 2, function(state)
    Settings.ESPPlayer = state
end)

makeToggle(visualsPage, "Generator ESP", "Highlight all generators", 3, function(state)
    Settings.ESPGenerator = state
end)

makeToggle(visualsPage, "Hook ESP", "Show hook locations", 4, function(state)
    Settings.ESPHook = state
end)

makeToggle(visualsPage, "Exit Gate ESP", "Show exit gate positions", 5, function(state)
    Settings.ESPGate = state
end)

-- ══════════════════════════════
--     MOVEMENT TAB
-- ══════════════════════════════

local movementPage = tabPages["Movement"]

makeSectionHeader(movementPage, "MOVEMENT", 1)

makeToggle(movementPage, "Speed Hack", "Increase walkspeed", 2, function(state)
    Settings.Speed = state
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = state and Settings.SpeedValue or 16 end
    end
end)

makeSlider(movementPage, "WalkSpeed", 16, 100, 16, 3, function(val)
    Settings.SpeedValue = val
    if Settings.Speed then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = val end
        end
    end
end)

makeToggle(movementPage, "Jump Power", "Increase jump height", 4, function(state)
    Settings.JumpPower = state
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = state and Settings.JumpValue or 50 end
    end
end)

makeSlider(movementPage, "JumpPower", 50, 300, 50, 5, function(val)
    Settings.JumpValue = val
    if Settings.JumpPower then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = val end
        end
    end
end)

makeToggle(movementPage, "Infinite Jump", "Jump while in mid-air", 6, function(state)
    Settings.InfiniteJump = state
end)

makeToggle(movementPage, "NoClip", "Walk through walls", 7, function(state)
    Settings.NoClip = state
end)

-- Respawn handler
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:WaitForChild("Humanoid")
    if Settings.Speed then hum.WalkSpeed = Settings.SpeedValue end
    if Settings.JumpPower then hum.JumpPower = Settings.JumpValue end
end)

-- ══════════════════════════════
--     FARM TAB
-- ══════════════════════════════

local farmPage = tabPages["Farm"]

makeSectionHeader(farmPage, "FARM METHOD 1 — FAKE SCRAP", 1)

local fakeScrapCard = makeCard(farmPage, 2)
fakeScrapCard.Size = UDim2.new(1, 0, 0, 58)

local fsLabel = Instance.new("TextLabel")
fsLabel.Size = UDim2.new(0.6, 0, 0, 20)
fsLabel.Position = UDim2.new(0, 14, 0, 6)
fsLabel.BackgroundTransparency = 1
fsLabel.Text = "Fake Scrap Display"
fsLabel.TextColor3 = C_TEXT
fsLabel.TextSize = 13
fsLabel.Font = Enum.Font.GothamBold
fsLabel.TextXAlignment = Enum.TextXAlignment.Left
fsLabel.Parent = fakeScrapCard

local fsDesc = Instance.new("TextLabel")
fsDesc.Size = UDim2.new(0.9, 0, 0, 14)
fsDesc.Position = UDim2.new(0, 14, 0, 26)
fsDesc.BackgroundTransparency = 1
fsDesc.Text = "Visual display only — server value unchanged"
fsDesc.TextColor3 = C_DIM
fsDesc.TextSize = 10
fsDesc.Font = Enum.Font.Gotham
fsDesc.TextXAlignment = Enum.TextXAlignment.Left
fsDesc.Parent = fakeScrapCard

local scrapAmountBox = Instance.new("TextBox")
scrapAmountBox.Size = UDim2.new(0, 80, 0, 22)
scrapAmountBox.Position = UDim2.new(1, -88, 0.5, -11)
scrapAmountBox.BackgroundColor3 = C_DARKRED
scrapAmountBox.Text = "9999"
scrapAmountBox.TextColor3 = C_TEXT
scrapAmountBox.TextSize = 12
scrapAmountBox.Font = Enum.Font.GothamBold
scrapAmountBox.BorderSizePixel = 0
scrapAmountBox.ClearTextOnFocus = false
scrapAmountBox.Parent = fakeScrapCard
Instance.new("UICorner", scrapAmountBox).CornerRadius = UDim.new(0, 6)

makeActionBtn(farmPage, "💰 Apply Fake Scrap", C_RED, 3, function()
    local amount = tonumber(scrapAmountBox.Text) or 9999
    -- Find scrap GUI and modify display
    local playerGui = player.PlayerGui
    for _, gui in pairs(playerGui:GetDescendants()) do
        if gui:IsA("TextLabel") or gui:IsA("TextButton") then
            if gui.Text:find("Scrap") or gui.Text:find("scrap") or gui.Text:match("%d+") then
                local ok = pcall(function()
                    if gui.Text:match("%d+") then
                        gui.Text = gui.Text:gsub("%d+", tostring(amount))
                    end
                end)
            end
        end
    end
    -- Also try game specific
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("scrap") and (v:IsA("TextLabel") or v:IsA("TextButton")) then
            pcall(function() v.Text = tostring(amount) end)
        end
    end
end)

makeSectionHeader(farmPage, "FARM METHOD 2 — AUTO PLAY", 5)

local autoFarmStatus = Instance.new("TextLabel")
autoFarmStatus.Size = UDim2.new(1, -16, 0, 20)
autoFarmStatus.BackgroundTransparency = 1
autoFarmStatus.Text = "Status: Idle"
autoFarmStatus.TextColor3 = C_DIM
autoFarmStatus.TextSize = 11
autoFarmStatus.Font = Enum.Font.Gotham
autoFarmStatus.TextXAlignment = Enum.TextXAlignment.Left
autoFarmStatus.LayoutOrder = 6
autoFarmStatus.Parent = farmPage

local function updateFarmStatus(msg, color)
    autoFarmStatus.Text = "Status: " .. msg
    autoFarmStatus.TextColor3 = color or C_DIM
end

makeToggle(farmPage, "Auto Farm", "Rescue hooks → Fix gens → Escape", 7, function(state)
    Settings.AutoFarm = state
    if state then
        updateFarmStatus("Running...", C_GREEN)
        coroutine.wrap(function()
            while Settings.AutoFarm do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then task.wait(1); continue end

                -- Step 1: Rescue hooked players
                updateFarmStatus("🔍 Looking for hooked players...", C_YELLOW)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if not Settings.AutoFarm then break end
                    if obj.Name:lower():find("hook") and obj:IsA("BasePart") then
                        hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                        updateFarmStatus("🤝 Rescuing hooked player...", C_YELLOW)
                        task.wait(3)
                    end
                end

                -- Step 2: Fix generators
                updateFarmStatus("⚡ Finding generators...", C_YELLOW)
                local genCount = 0
                for _, obj in pairs(workspace:GetDescendants()) do
                    if not Settings.AutoFarm then break end
                    if (obj.Name:lower():find("generator") or obj.Name:lower():find("gen")) and obj:IsA("BasePart") then
                        hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                        updateFarmStatus("🔧 Repairing generator " .. genCount+1 .. "/5...", C_YELLOW)
                        task.wait(0.1)
                        -- Simulate generator interaction
                        local args = {obj}
                        for _, remote in pairs(game:GetDescendants()) do
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("gen") or remote.Name:lower():find("repair")) then
                                pcall(function() remote:FireServer(unpack(args)) end)
                            end
                        end
                        task.wait(5)
                        genCount += 1
                        if genCount >= 5 then break end
                    end
                end

                -- Step 3: Open exit gate & escape
                if genCount >= 5 then
                    updateFarmStatus("🚪 Opening exit gate...", C_GREEN)
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not Settings.AutoFarm then break end
                        if (obj.Name:lower():find("gate") or obj.Name:lower():find("exit") or obj.Name:lower():find("door")) and obj:IsA("BasePart") then
                            hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            task.wait(2)
                            -- Interact with gate
                            for _, remote in pairs(game:GetDescendants()) do
                                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("gate") or remote.Name:lower():find("escape") or remote.Name:lower():find("door")) then
                                    pcall(function() remote:FireServer() end)
                                end
                            end
                            task.wait(22)
                            updateFarmStatus("✅ Escaped! Waiting next round...", C_GREEN)
                            task.wait(15)
                            break
                        end
                    end
                end

                task.wait(2)
            end
            updateFarmStatus("Idle", C_DIM)
        end)()
    else
        updateFarmStatus("Stopped", C_DIM)
    end
end)

-- ══════════════════════════════
--     PLAYER TAB
-- ══════════════════════════════

local playerPage = tabPages["Player"]

makeSectionHeader(playerPage, "SELECT PLAYER", 1)

local selectedTarget = nil
local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, -16, 0, 20)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Text = "Selected: None"
selectedLabel.TextColor3 = C_DIM
selectedLabel.TextSize = 11
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.LayoutOrder = 2
selectedLabel.Parent = playerPage

local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(1, 0, 0, 160)
playerListFrame.BackgroundColor3 = C_CARD
playerListFrame.BorderSizePixel = 0
playerListFrame.LayoutOrder = 3
playerListFrame.Parent = playerPage
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)

local playerScroll = Instance.new("ScrollingFrame")
playerScroll.Size = UDim2.new(1, 0, 1, 0)
playerScroll.BackgroundTransparency = 1
playerScroll.BorderSizePixel = 0
playerScroll.ScrollBarThickness = 3
playerScroll.ScrollBarImageColor3 = C_RED
playerScroll.Parent = playerListFrame

local playerScrollLayout = Instance.new("UIListLayout")
playerScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerScrollLayout.Padding = UDim.new(0, 2)
playerScrollLayout.Parent = playerScroll

playerScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    playerScroll.CanvasSize = UDim2.new(0, 0, 0, playerScrollLayout.AbsoluteContentSize.Y)
end)

local function refreshPlayerList()
    for _, v in pairs(playerScroll:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -8, 0, 32)
            pBtn.BackgroundColor3 = C_DARKRED
            pBtn.BackgroundTransparency = 0.5
            pBtn.Text = "👤 " .. p.Name
            pBtn.TextColor3 = C_TEXT
            pBtn.TextSize = 12
            pBtn.Font = Enum.Font.Gotham
            pBtn.BorderSizePixel = 0
            pBtn.Parent = playerScroll
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)

            pBtn.MouseButton1Click:Connect(function()
                selectedTarget = p
                selectedLabel.Text = "Selected: " .. p.Name
                selectedLabel.TextColor3 = C_BRIGHTRED
                for _, b in pairs(playerScroll:GetChildren()) do
                    if b:IsA("TextButton") then
                        b.BackgroundTransparency = 0.5
                        b.TextColor3 = C_TEXT
                    end
                end
                pBtn.BackgroundTransparency = 0
                pBtn.TextColor3 = C_WHITE
            end)
        end
    end
end

refreshPlayerList()

makeSectionHeader(playerPage, "ACTIONS", 4)

local _, refreshBtnObj = makeActionBtn(playerPage, "🔄 Refresh Player List", C_DARKRED, 5, function()
    refreshPlayerList()
end)

makeActionBtn(playerPage, "🌀 Teleport to Player", C_RED, 6, function()
    if not selectedTarget then return end
    local char = player.Character
    local targetChar = selectedTarget.Character
    if char and targetChar then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        if hrp and targetHrp then
            hrp.CFrame = CFrame.new(targetHrp.Position + Vector3.new(3, 0, 0))
        end
    end
end)

makeActionBtn(playerPage, "📌 Spectate Player", Color3.fromRGB(60, 0, 80), 7, function()
    if not selectedTarget then return end
    local targetChar = selectedTarget.Character
    if targetChar then
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        if targetHrp then
            camera.CameraType = Enum.CameraType.Follow
            camera.CameraSubject = targetChar:FindFirstChildOfClass("Humanoid")
        end
    end
end)

makeActionBtn(playerPage, "👁 Stop Spectate", C_DARKRED, 8, function()
    local char = player.Character
    if char then
        camera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
        camera.CameraType = Enum.CameraType.Custom
    end
end)

-- ══════════════════════════════
--     MISC TAB
-- ══════════════════════════════

local miscPage = tabPages["Misc"]

makeSectionHeader(miscPage, "UTILITY", 1)

makeToggle(miscPage, "Anti AFK", "Prevent auto-kick", 2, function(state)
    Settings.AntiAFK = state
    if state then
        local VU = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.5)
            VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

makeToggle(miscPage, "FPS Boost", "Reduce render quality for more FPS", 3, function(state)
    Settings.FPSBoost = state
    if state then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end)

makeSectionHeader(miscPage, "SERVER", 4)

makeActionBtn(miscPage, "🔄 Server Hop", C_RED, 5, function()
    local servers = {}
    local ok, result = pcall(function()
        local data = game:GetService("HttpService"):JSONDecode(
            game:GetService("HttpService"):GetAsync(
                "https://games.roproxy.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=25"
            )
        )
        servers = data.data
    end)
    if ok and servers and #servers > 0 then
        for _, server in ipairs(servers) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id)
                return
            end
        end
    end
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

makeActionBtn(miscPage, "🔁 Rejoin", C_DARKRED, 6, function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

-- ══════════════════════════════
--     RUNTIME LOGIC
-- ══════════════════════════════

-- Aimbot helper
local function getClosestPlayer()
    local closest = nil
    local closestDist = Settings.AimbotFOV
    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p == player then continue end
        local char = p.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local target = char:FindFirstChild(Settings.AimbotPart) or char:FindFirstChild("HumanoidRootPart")
        if not target then continue end

        local screenPos, onScreen = camera:WorldToScreenPoint(target.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist < closestDist then
            closestDist = dist
            closest = target
        end
    end

    return closest
end

-- ESP drawings storage
local espDrawings = {}

local function clearESP()
    for _, d in pairs(espDrawings) do
        for _, v in pairs(d) do
            pcall(function() v:Remove() end)
        end
    end
    espDrawings = {}
end

local function makeESPBox(player, color)
    local box = Drawing.new("Square")
    box.Color = color
    box.Thickness = 1.5
    box.Filled = false
    box.Visible = false

    local nameLbl = Drawing.new("Text")
    nameLbl.Color = color
    nameLbl.Size = 13
    nameLbl.Font = 2
    nameLbl.Outline = true
    nameLbl.Visible = false

    local distLbl = Drawing.new("Text")
    distLbl.Color = C_DIM
    distLbl.Size = 11
    distLbl.Font = 2
    distLbl.Outline = true
    distLbl.Visible = false

    return {box = box, name = nameLbl, dist = distLbl}
end

-- Main render loop
RunService.RenderStepped:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    -- FOV circle
    fovCircle.Visible = Settings.Aimbot
    fovCircle.Radius = Settings.AimbotFOV
    fovCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    -- Aimbot
    if Settings.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = Settings.StrongLock and Settings.LockedTarget or getClosestPlayer()
        if target and target.Parent then
            if Settings.StrongLock then Settings.LockedTarget = target end
            local targetPos = camera:WorldToScreenPoint(target.Position)
            local targetVec = Vector2.new(targetPos.X, targetPos.Y)
            local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            local delta = targetVec - center
            local smooth = Settings.AimbotSmooth
            mousemoverel(delta.X * smooth, delta.Y * smooth)
        end
    end

    -- Silent aim
    if Settings.SilentAim then
        local target = getClosestPlayer()
        if target and target.Parent then
            local part = target.Parent:FindFirstChild("Head") or target
            mouse.Hit = CFrame.new(part.Position)
            mouse.Target = part
        end
    end

    -- NoClip
    if Settings.NoClip and char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end

    -- Infinite Jump
    if Settings.InfiniteJump and char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    -- ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p == player then continue end

        if not espDrawings[p.Name] then
            local isKiller = p.Team and p.Team.Name:lower():find("killer")
            local color = isKiller and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 200, 255)
            espDrawings[p.Name] = makeESPBox(p, color)
        end

        local drawing = espDrawings[p.Name]
        local pChar = p.Character
        local pHRP = pChar and pChar:FindFirstChild("HumanoidRootPart")
        local pHum = pChar and pChar:FindFirstChildOfClass("Humanoid")

        if Settings.ESPPlayer and pHRP and pHum and pHum.Health > 0 then
            local screenPos, onScreen = camera:WorldToScreenPoint(pHRP.Position)

            if onScreen then
                local scaleFactor = 1 / (screenPos.Z * math.tan(math.rad(camera.FieldOfView / 2)) * 2 / camera.ViewportSize.Y)
                local boxSize = Vector2.new(3.5 * scaleFactor, 5.5 * scaleFactor)
                local boxPos = Vector2.new(screenPos.X - boxSize.X/2, screenPos.Y - boxSize.Y/2)

                drawing.box.Size = boxSize
                drawing.box.Position = boxPos
                drawing.box.Visible = true

                drawing.name.Text = p.Name
                drawing.name.Position = Vector2.new(screenPos.X, boxPos.Y - 16)
                drawing.name.Visible = true

                local dist = math.floor((pHRP.Position - (hrp and hrp.Position or Vector3.new())).Magnitude)
                drawing.dist.Text = dist .. "m"
                drawing.dist.Position = Vector2.new(screenPos.X, boxPos.Y + boxSize.Y + 2)
                drawing.dist.Visible = true
            else
                drawing.box.Visible = false
                drawing.name.Visible = false
                drawing.dist.Visible = false
            end
        else
            drawing.box.Visible = false
            drawing.name.Visible = false
            drawing.dist.Visible = false
        end
    end

    -- Generator ESP
    if Settings.ESPGenerator then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("generator") and obj:IsA("BasePart") then
                local screenPos, onScreen = camera:WorldToScreenPoint(obj.Position)
                if onScreen then
                    if not obj:FindFirstChild("ESPLabel") then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "ESPLabel"
                        bill.Size = UDim2.new(0, 80, 0, 30)
                        bill.AlwaysOnTop = true
                        bill.Parent = obj

                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = "⚡ Generator"
                        lbl.TextColor3 = C_YELLOW
                        lbl.TextSize = 12
                        lbl.Font = Enum.Font.GothamBold
                        lbl.Parent = bill
                    end
                end
            end
        end
    end

    -- Hook ESP
    if Settings.ESPHook then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("hook") and obj:IsA("BasePart") then
                if not obj:FindFirstChild("ESPHookLabel") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "ESPHookLabel"
                    bill.Size = UDim2.new(0, 80, 0, 30)
                    bill.AlwaysOnTop = true
                    bill.Parent = obj

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "🪝 Hook"
                    lbl.TextColor3 = Color3.fromRGB(255, 100, 100)
                    lbl.TextSize = 12
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = bill
                end
            end
        end
    end

    -- Gate ESP
    if Settings.ESPGate then
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name:lower():find("gate") or obj.Name:lower():find("exit")) and obj:IsA("BasePart") then
                if not obj:FindFirstChild("ESPGateLabel") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "ESPGateLabel"
                    bill.Size = UDim2.new(0, 100, 0, 30)
                    bill.AlwaysOnTop = true
                    bill.Parent = obj

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "🚪 Exit Gate"
                    lbl.TextColor3 = C_GREEN
                    lbl.TextSize = 12
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = bill
                end
            end
        end
    end
end)

-- ══════════════════════════════
--     WINDOW CONTROLS
-- ══════════════════════════════

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    minBtn.Text = minimized and "+" or "—"
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = minimized and UDim2.new(0, 580, 0, 46) or UDim2.new(0, 580, 0, 420)
    }):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.wait(0.3)
    fovCircle:Remove()
    clearESP()
    screenGui:Destroy()
end)

-- ══════════════════════════════
--     DEFAULT TAB
-- ══════════════════════════════

switchTab("Combat", tabs["Combat"])

print("💀 H4ll0 W0rld | Violence District Pro v2.1 loaded!")
