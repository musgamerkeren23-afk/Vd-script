local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local VALID_KEY = "VD_Pro_25926#2952#48key"
local GET_KEY_URL = "https://lootdest.org/s?fr8J0dDQ"

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
--         KEY SYSTEM
-- ══════════════════════════════

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VDKeySystem"
keyGui.ResetOnSpawn = false
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
keyGui.Parent = player:WaitForChild("PlayerGui")

-- Background blur/overlay
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0
overlay.ZIndex = 1
overlay.Parent = keyGui

-- Key frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 360, 0, 260)
keyFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
keyFrame.BackgroundColor3 = C_BG
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.ZIndex = 2
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local keyFrameStroke = Instance.new("UIStroke")
keyFrameStroke.Color = C_RED
keyFrameStroke.Thickness = 1.5
keyFrameStroke.Parent = keyFrame

-- Glow
local keyGlow = Instance.new("ImageLabel")
keyGlow.Size = UDim2.new(1, 50, 1, 50)
keyGlow.Position = UDim2.new(0, -25, 0, -25)
keyGlow.BackgroundTransparency = 1
keyGlow.Image = "rbxassetid://5028857084"
keyGlow.ImageColor3 = C_RED
keyGlow.ImageTransparency = 0.75
keyGlow.ZIndex = 1
keyGlow.Parent = keyFrame

-- Title bar
local keyTitleBar = Instance.new("Frame")
keyTitleBar.Size = UDim2.new(1, 0, 0, 44)
keyTitleBar.BackgroundColor3 = C_SIDEBAR
keyTitleBar.BorderSizePixel = 0
keyTitleBar.ZIndex = 3
keyTitleBar.Parent = keyFrame
Instance.new("UICorner", keyTitleBar).CornerRadius = UDim.new(0, 10)

local keyGradient = Instance.new("UIGradient")
keyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, C_SIDEBAR),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0))
})
keyGradient.Rotation = 90
keyGradient.Parent = keyTitleBar

local keyTitleSep = Instance.new("Frame")
keyTitleSep.Size = UDim2.new(1, 0, 0, 1)
keyTitleSep.Position = UDim2.new(0, 0, 1, 0)
keyTitleSep.BackgroundColor3 = C_RED
keyTitleSep.BackgroundTransparency = 0.5
keyTitleSep.BorderSizePixel = 0
keyTitleSep.ZIndex = 3
keyTitleSep.Parent = keyTitleBar

-- Logo
local keyLogo = Instance.new("TextLabel")
keyLogo.Size = UDim2.new(0, 32, 0, 32)
keyLogo.Position = UDim2.new(0, 8, 0.5, -16)
keyLogo.BackgroundColor3 = C_RED
keyLogo.Text = "💀"
keyLogo.TextSize = 16
keyLogo.Font = Enum.Font.GothamBold
keyLogo.BorderSizePixel = 0
keyLogo.ZIndex = 4
keyLogo.Parent = keyTitleBar
Instance.new("UICorner", keyLogo).CornerRadius = UDim.new(0, 8)

-- Title
local keyTitleLbl = Instance.new("TextLabel")
keyTitleLbl.Size = UDim2.new(1, -90, 0, 20)
keyTitleLbl.Position = UDim2.new(0, 48, 0, 6)
keyTitleLbl.BackgroundTransparency = 1
keyTitleLbl.Text = "H4ll0 W0rld | VD Pro"
keyTitleLbl.TextColor3 = C_BRIGHTRED
keyTitleLbl.TextSize = 13
keyTitleLbl.Font = Enum.Font.GothamBold
keyTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
keyTitleLbl.ZIndex = 4
keyTitleLbl.Parent = keyTitleBar

local keySubLbl = Instance.new("TextLabel")
keySubLbl.Size = UDim2.new(1, -90, 0, 14)
keySubLbl.Position = UDim2.new(0, 48, 0, 26)
keySubLbl.BackgroundTransparency = 1
keySubLbl.Text = "Violence District Pro v2.1"
keySubLbl.TextColor3 = C_DARKRED
keySubLbl.TextSize = 10
keySubLbl.Font = Enum.Font.Gotham
keySubLbl.TextXAlignment = Enum.TextXAlignment.Left
keySubLbl.ZIndex = 4
keySubLbl.Parent = keyTitleBar

-- Close button
local keyCloseBtn = Instance.new("TextButton")
keyCloseBtn.Size = UDim2.new(0, 26, 0, 26)
keyCloseBtn.Position = UDim2.new(1, -32, 0.5, -13)
keyCloseBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
keyCloseBtn.Text = "✕"
keyCloseBtn.TextColor3 = C_WHITE
keyCloseBtn.TextSize = 12
keyCloseBtn.Font = Enum.Font.GothamBold
keyCloseBtn.BorderSizePixel = 0
keyCloseBtn.ZIndex = 4
keyCloseBtn.Parent = keyTitleBar
Instance.new("UICorner", keyCloseBtn).CornerRadius = UDim.new(0, 6)

keyCloseBtn.MouseButton1Click:Connect(function()
    keyGui:Destroy()
end)

-- Content
local keyContent = Instance.new("Frame")
keyContent.Size = UDim2.new(1, 0, 1, -44)
keyContent.Position = UDim2.new(0, 0, 0, 44)
keyContent.BackgroundTransparency = 1
keyContent.ZIndex = 3
keyContent.Parent = keyFrame

-- Lock icon
local lockIcon = Instance.new("TextLabel")
lockIcon.Size = UDim2.new(0, 40, 0, 40)
lockIcon.Position = UDim2.new(0.5, -20, 0, 14)
lockIcon.BackgroundTransparency = 1
lockIcon.Text = "🔐"
lockIcon.TextSize = 28
lockIcon.Font = Enum.Font.Gotham
lockIcon.TextXAlignment = Enum.TextXAlignment.Center
lockIcon.ZIndex = 4
lockIcon.Parent = keyContent

-- Description
local keyDescLbl = Instance.new("TextLabel")
keyDescLbl.Size = UDim2.new(1, -30, 0, 16)
keyDescLbl.Position = UDim2.new(0, 15, 0, 56)
keyDescLbl.BackgroundTransparency = 1
keyDescLbl.Text = "Enter your key to access VD Pro features"
keyDescLbl.TextColor3 = C_DIM
keyDescLbl.TextSize = 11
keyDescLbl.Font = Enum.Font.Gotham
keyDescLbl.TextXAlignment = Enum.TextXAlignment.Center
keyDescLbl.ZIndex = 4
keyDescLbl.Parent = keyContent

-- Input box
local keyInputFrame = Instance.new("Frame")
keyInputFrame.Size = UDim2.new(1, -30, 0, 36)
keyInputFrame.Position = UDim2.new(0, 15, 0, 78)
keyInputFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 0)
keyInputFrame.BorderSizePixel = 0
keyInputFrame.ZIndex = 4
keyInputFrame.Parent = keyContent
Instance.new("UICorner", keyInputFrame).CornerRadius = UDim.new(0, 8)

local keyInputStroke = Instance.new("UIStroke")
keyInputStroke.Color = C_BORDER
keyInputStroke.Thickness = 1
keyInputStroke.Parent = keyInputFrame

local keyIcon = Instance.new("TextLabel")
keyIcon.Size = UDim2.new(0, 30, 1, 0)
keyIcon.BackgroundTransparency = 1
keyIcon.Text = "🔑"
keyIcon.TextSize = 14
keyIcon.Font = Enum.Font.Gotham
keyIcon.ZIndex = 5
keyIcon.Parent = keyInputFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -36, 1, 0)
keyInput.Position = UDim2.new(0, 32, 0, 0)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "Paste key here..."
keyInput.PlaceholderColor3 = Color3.fromRGB(70, 30, 30)
keyInput.TextColor3 = C_TEXT
keyInput.TextSize = 12
keyInput.Font = Enum.Font.Gotham
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.ClearTextOnFocus = false
keyInput.BorderSizePixel = 0
keyInput.ZIndex = 5
keyInput.Parent = keyInputFrame

-- Status label
local keyStatusLbl = Instance.new("TextLabel")
keyStatusLbl.Size = UDim2.new(1, -30, 0, 16)
keyStatusLbl.Position = UDim2.new(0, 15, 0, 118)
keyStatusLbl.BackgroundTransparency = 1
keyStatusLbl.Text = ""
keyStatusLbl.TextColor3 = C_RED
keyStatusLbl.TextSize = 11
keyStatusLbl.Font = Enum.Font.Gotham
keyStatusLbl.TextXAlignment = Enum.TextXAlignment.Center
keyStatusLbl.ZIndex = 4
keyStatusLbl.Parent = keyContent

-- Verify button
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(1, -30, 0, 36)
verifyBtn.Position = UDim2.new(0, 15, 0, 138)
verifyBtn.BackgroundColor3 = C_RED
verifyBtn.Text = "🔓 Verify Key"
verifyBtn.TextColor3 = C_WHITE
verifyBtn.TextSize = 13
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.BorderSizePixel = 0
verifyBtn.ZIndex = 4
verifyBtn.Parent = keyContent
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 8)

local verifyGrad = Instance.new("UIGradient")
verifyGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 0))
})
verifyGrad.Rotation = 90
verifyGrad.Parent = verifyBtn

-- Get Key button
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(1, -30, 0, 30)
getKeyBtn.Position = UDim2.new(0, 15, 0, 182)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 20)
getKeyBtn.Text = "🔗 Get Key — tap to copy link"
getKeyBtn.TextColor3 = C_GREEN
getKeyBtn.TextSize = 11
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.BorderSizePixel = 0
getKeyBtn.ZIndex = 4
getKeyBtn.Parent = keyContent
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

local getKeyStroke = Instance.new("UIStroke")
getKeyStroke.Color = Color3.fromRGB(0, 80, 30)
getKeyStroke.Thickness = 1
getKeyStroke.Parent = getKeyBtn

getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(GET_KEY_URL)
    getKeyBtn.Text = "✅ Link copied! Open in browser"
    getKeyBtn.TextColor3 = C_WHITE
    TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 80, 30)
    }):Play()
    task.wait(2.5)
    getKeyBtn.Text = "🔗 Get Key — tap to copy link"
    getKeyBtn.TextColor3 = C_GREEN
    TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 50, 20)
    }):Play()
end)

-- Shake animation
local function shakeKeyFrame()
    local orig = keyFrame.Position
    for i = 1, 4 do
        TweenService:Create(keyFrame, TweenInfo.new(0.04), {
            Position = UDim2.new(orig.X.Scale, orig.X.Offset + 10, orig.Y.Scale, orig.Y.Offset)
        }):Play()
        task.wait(0.04)
        TweenService:Create(keyFrame, TweenInfo.new(0.04), {
            Position = UDim2.new(orig.X.Scale, orig.X.Offset - 10, orig.Y.Scale, orig.Y.Offset)
        }):Play()
        task.wait(0.04)
    end
    TweenService:Create(keyFrame, TweenInfo.new(0.04), {Position = orig}):Play()
end

-- Flash input red on wrong key
local function flashWrong()
    TweenService:Create(keyInputStroke, TweenInfo.new(0.15), {Color = C_BRIGHTRED}):Play()
    TweenService:Create(keyInputFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 0, 0)}):Play()
    task.wait(0.4)
    TweenService:Create(keyInputStroke, TweenInfo.new(0.3), {Color = C_BORDER}):Play()
    TweenService:Create(keyInputFrame, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(8, 0, 0)}):Play()
end

-- Verify logic
local function loadMainScript()
    -- ══════════════════════════════
    --         SETTINGS
    -- ══════════════════════════════

    local Settings = {
        Aimbot = false,
        AimbotFOV = 100,
        AimbotSmooth = 0.2,
        AimbotPart = "Head",
        SilentAim = false,
        StrongLock = false,
        LockedTarget = nil,
        ESPPlayer = false,
        ESPGenerator = false,
        ESPHook = false,
        ESPGate = false,
        Speed = false,
        SpeedValue = 16,
        JumpPower = false,
        JumpValue = 50,
        InfiniteJump = false,
        NoClip = false,
        FakeScrap = false,
        AutoFarm = false,
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

    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 50, 1, 50)
    glow.Position = UDim2.new(0, -25, 0, -25)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = C_RED
    glow.ImageTransparency = 0.7
    glow.ZIndex = 0
    glow.Parent = mainFrame

    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 46)
    titleBar.BackgroundColor3 = C_SIDEBAR
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C_SIDEBAR),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0))
    })
    titleGradient.Rotation = 90
    titleGradient.Parent = titleBar

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

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -140, 0, 22)
    titleLabel.Position = UDim2.new(0, 52, 0, 6)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "H4ll0 W0rld | Violence District Pro"
    titleLabel.TextColor3 = C_BRIGHTRED
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0, 150, 0, 16)
    versionLabel.Position = UDim2.new(0, 52, 0, 26)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "v2.1 | 💀 Key Verified ✅"
    versionLabel.TextColor3 = C_DARKRED
    versionLabel.TextSize = 10
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = titleBar

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

    local titleSep = Instance.new("Frame")
    titleSep.Size = UDim2.new(1, 0, 0, 1)
    titleSep.Position = UDim2.new(0, 0, 1, 0)
    titleSep.BackgroundColor3 = C_RED
    titleSep.BackgroundTransparency = 0.5
    titleSep.BorderSizePixel = 0
    titleSep.Parent = titleBar

    -- Flicker effect
    coroutine.wrap(function()
        while titleLabel and titleLabel.Parent do
            titleLabel.TextTransparency = 0.5
            task.wait(0.04)
            titleLabel.TextTransparency = 0
            task.wait(math.random(4, 9))
        end
    end)()

    -- Sidebar
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

    -- Content area
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
        {name="Combat", icon="⚔️", order=1},
        {name="Visuals", icon="👁", order=2},
        {name="Movement", icon="⚡", order=3},
        {name="Farm", icon="💰", order=4},
        {name="Player", icon="👤", order=5},
        {name="Misc", icon="⚙️", order=6},
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
            activeTab.BackgroundTransparency = 1
            local l = activeTab:FindFirstChildWhichIsA("TextLabel")
            if l then l.TextColor3 = C_DIM end
            local ind = activeTab:FindFirstChild("Indicator")
            if ind then ind.Visible = false end
        end

        btn.BackgroundColor3 = C_CARD
        btn.BackgroundTransparency = 0
        local l = btn:FindFirstChildWhichIsA("TextLabel")
        if l then l.TextColor3 = C_BRIGHTRED end
        local ind = btn:FindFirstChild("Indicator")
        if ind then ind.Visible = true end
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
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency=0.7, BackgroundColor3=C_CARD}):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if tabBtn ~= activeTab then
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
            end
        end)

        local page = makePage()
        tabs[data.name] = tabBtn
        tabPages[data.name] = page
        tabBtn.MouseButton1Click:Connect(function() switchTab(data.name, tabBtn) end)
    end

    -- ══════════════════════════════
    --         UI COMPONENTS
    -- ══════════════════════════════

    local function makeCard(parent, order, h)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, h or 46)
        card.BackgroundColor3 = C_CARD
        card.BorderSizePixel = 0
        card.LayoutOrder = order
        card.Parent = parent
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
        local s = Instance.new("UIStroke")
        s.Color = C_BORDER
        s.Thickness = 1
        s.Parent = card
        return card
    end

    local function makeToggle(parent, text, desc, order, callback)
        local card = makeCard(parent, order)

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 4, 0.7, 0)
        bar.Position = UDim2.new(0, 0, 0.15, 0)
        bar.BackgroundColor3 = C_DARKRED
        bar.BorderSizePixel = 0
        bar.Parent = card
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 3)

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
                TweenService:Create(togBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,60,20)}):Play()
                TweenService:Create(bar, TweenInfo.new(0.2), {BackgroundColor3 = C_BRIGHTRED}):Play()
            else
                togBtn.Text = "OFF"
                togBtn.TextColor3 = Color3.fromRGB(180,60,60)
                TweenService:Create(togBtn, TweenInfo.new(0.2), {BackgroundColor3 = C_DARKRED}):Play()
                TweenService:Create(bar, TweenInfo.new(0.2), {BackgroundColor3 = C_DARKRED}):Play()
            end
            if callback then callback(state) end
        end)

        return card, togBtn
    end

    local function makeSlider(parent, text, minV, maxV, defV, order, callback)
        local card = makeCard(parent, order, 58)

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
        valLbl.Text = tostring(defV)
        valLbl.TextColor3 = C_BRIGHTRED
        valLbl.TextSize = 12
        valLbl.Font = Enum.Font.GothamBold
        valLbl.TextXAlignment = Enum.TextXAlignment.Right
        valLbl.Parent = card

        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, -28, 0, 8)
        bg.Position = UDim2.new(0, 14, 0, 32)
        bg.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        bg.BorderSizePixel = 0
        bg.Parent = card
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defV-minV)/(maxV-minV), 0, 1, 0)
        fill.BackgroundColor3 = C_RED
        fill.BorderSizePixel = 0
        fill.Parent = bg
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 14, 0, 14)
        knob.Position = UDim2.new((defV-minV)/(maxV-minV), -7, 0.5, -7)
        knob.BackgroundColor3 = C_BRIGHTRED
        knob.BorderSizePixel = 0
        knob.Parent = bg
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local dragging = false
        bg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local rel = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                local val = math.floor(minV + (maxV - minV) * rel)
                fill.Size = UDim2.new(rel, 0, 1, 0)
                knob.Position = UDim2.new(rel, -7, 0.5, -7)
                valLbl.Text = tostring(val)
                if callback then callback(val) end
            end
        end)
        return card
    end

    local function makeDropdown(parent, text, options, order, callback)
        local card = makeCard(parent, order)
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

        local dl = Instance.new("UIListLayout")
        dl.SortOrder = Enum.SortOrder.LayoutOrder
        dl.Parent = dropList

        for i, opt in ipairs(options) do
            local ob = Instance.new("TextButton")
            ob.Size = UDim2.new(1, 0, 0, 28)
            ob.BackgroundColor3 = C_CARD
            ob.Text = opt
            ob.TextColor3 = C_TEXT
            ob.TextSize = 11
            ob.Font = Enum.Font.Gotham
            ob.BorderSizePixel = 0
            ob.LayoutOrder = i
            ob.ZIndex = 11
            ob.Parent = dropList
            Instance.new("UICorner", ob).CornerRadius = UDim.new(0, 4)
            ob.MouseButton1Click:Connect(function()
                dropBtn.Text = opt .. " ▼"
                dropList.Visible = false
                if callback then callback(opt) end
            end)
            ob.MouseEnter:Connect(function() ob.BackgroundColor3 = C_DARKRED end)
            ob.MouseLeave:Connect(function() ob.BackgroundColor3 = C_CARD end)
        end

        dropBtn.MouseButton1Click:Connect(function()
            dropList.Visible = not dropList.Visible
        end)
        return card
    end

    local function makeSection(parent, text, order)
        local h = Instance.new("TextLabel")
        h.Size = UDim2.new(1, 0, 0, 24)
        h.BackgroundTransparency = 1
        h.Text = "  " .. text
        h.TextColor3 = C_RED
        h.TextSize = 11
        h.Font = Enum.Font.GothamBold
        h.TextXAlignment = Enum.TextXAlignment.Left
        h.LayoutOrder = order
        h.Parent = parent
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0.3, 0, 0, 1)
        line.Position = UDim2.new(0.7, 0, 0.5, 0)
        line.BackgroundColor3 = C_DARKRED
        line.BorderSizePixel = 0
        line.Parent = h
        return h
    end

    local function makeActionBtn(parent, text, color, order, callback)
        local card = makeCard(parent, order, 40)
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
        btn.MouseButton1Click:Connect(function() if callback then callback() end end)
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
    makeSection(combatPage, "AIMBOT", 1)
    makeToggle(combatPage, "Aimbot", "Auto aim nearest survivor/killer", 2, function(s) Settings.Aimbot = s end)
    makeToggle(combatPage, "Silent Aim", "Bullet redirects to target", 3, function(s) Settings.SilentAim = s end)
    makeToggle(combatPage, "Strong Lock", "Permanent target lock", 4, function(s)
        Settings.StrongLock = s
        if not s then Settings.LockedTarget = nil end
    end)
    makeSlider(combatPage, "FOV Radius", 20, 300, 100, 5, function(v) Settings.AimbotFOV = v end)
    makeSlider(combatPage, "Smoothness", 1, 20, 4, 6, function(v) Settings.AimbotSmooth = v / 20 end)
    makeDropdown(combatPage, "Aim Part", {"Head","HumanoidRootPart","Torso"}, 7, function(v) Settings.AimbotPart = v end)

    -- FOV Circle
    local fovCircle = Drawing.new("Circle")
    fovCircle.Radius = Settings.AimbotFOV
    fovCircle.Color = C_BRIGHTRED
    fovCircle.Thickness = 1.5
    fovCircle.Filled = false
    fovCircle.Visible = false
    fovCircle.NumSides = 64
    fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

    -- ══════════════════════════════
    --     VISUALS TAB
    -- ══════════════════════════════

    local visualsPage = tabPages["Visuals"]
    makeSection(visualsPage, "ESP", 1)
    makeToggle(visualsPage, "Player ESP", "Box + name + distance", 2, function(s) Settings.ESPPlayer = s end)
    makeToggle(visualsPage, "Generator ESP", "Show generator locations", 3, function(s) Settings.ESPGenerator = s end)
    makeToggle(visualsPage, "Hook ESP", "Show hook locations", 4, function(s) Settings.ESPHook = s end)
    makeToggle(visualsPage, "Exit Gate ESP", "Show exit gate positions", 5, function(s) Settings.ESPGate = s end)

    -- ══════════════════════════════
    --     MOVEMENT TAB
    -- ══════════════════════════════

    local movementPage = tabPages["Movement"]
    makeSection(movementPage, "MOVEMENT", 1)

    makeToggle(movementPage, "Speed Hack", "Increase walkspeed", 2, function(s)
        Settings.Speed = s
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = s and Settings.SpeedValue or 16 end
        end
    end)

    makeSlider(movementPage, "WalkSpeed", 16, 100, 16, 3, function(v)
        Settings.SpeedValue = v
        if Settings.Speed then
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = v end
            end
        end
    end)

    makeToggle(movementPage, "Jump Power", "Increase jump height", 4, function(s)
        Settings.JumpPower = s
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = s and Settings.JumpValue or 50 end
        end
    end)

    makeSlider(movementPage, "JumpPower", 50, 300, 50, 5, function(v)
        Settings.JumpValue = v
        if Settings.JumpPower then
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower = v end
            end
        end
    end)

    makeToggle(movementPage, "Infinite Jump", "Jump while mid-air", 6, function(s) Settings.InfiniteJump = s end)
    makeToggle(movementPage, "NoClip", "Walk through walls", 7, function(s) Settings.NoClip = s end)

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
    makeSection(farmPage, "METHOD 1 — FAKE SCRAP", 1)

    local fsCard = makeCard(farmPage, 2, 58)
    local fsLbl = Instance.new("TextLabel")
    fsLbl.Size = UDim2.new(0.6, 0, 0, 20)
    fsLbl.Position = UDim2.new(0, 14, 0, 6)
    fsLbl.BackgroundTransparency = 1
    fsLbl.Text = "Fake Scrap Display"
    fsLbl.TextColor3 = C_TEXT
    fsLbl.TextSize = 13
    fsLbl.Font = Enum.Font.GothamBold
    fsLbl.TextXAlignment = Enum.TextXAlignment.Left
    fsLbl.Parent = fsCard

    local fsDesc = Instance.new("TextLabel")
    fsDesc.Size = UDim2.new(0.9, 0, 0, 14)
    fsDesc.Position = UDim2.new(0, 14, 0, 26)
    fsDesc.BackgroundTransparency = 1
    fsDesc.Text = "⚠️ Visual only — server value unchanged"
    fsDesc.TextColor3 = C_YELLOW
    fsDesc.TextSize = 10
    fsDesc.Font = Enum.Font.Gotham
    fsDesc.TextXAlignment = Enum.TextXAlignment.Left
    fsDesc.Parent = fsCard

    local scrapBox = Instance.new("TextBox")
    scrapBox.Size = UDim2.new(0, 80, 0, 22)
    scrapBox.Position = UDim2.new(1, -88, 0.5, -11)
    scrapBox.BackgroundColor3 = C_DARKRED
    scrapBox.Text = "9999"
    scrapBox.TextColor3 = C_TEXT
    scrapBox.TextSize = 12
    scrapBox.Font = Enum.Font.GothamBold
    scrapBox.BorderSizePixel = 0
    scrapBox.ClearTextOnFocus = false
    scrapBox.Parent = fsCard
    Instance.new("UICorner", scrapBox).CornerRadius = UDim.new(0, 6)

    makeActionBtn(farmPage, "💰 Apply Fake Scrap", C_RED, 3, function()
        local amount = tonumber(scrapBox.Text) or 9999
        local playerGui = player.PlayerGui
        for _, gui in pairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextLabel") or gui:IsA("TextButton")) then
                pcall(function()
                    if gui.Text:lower():find("scrap") or gui.Text:lower():find("emblem") then
                        gui.Text = gui.Text:gsub("%d+", tostring(amount))
                    end
                end)
            end
        end
    end)

    makeSection(farmPage, "METHOD 2 — AUTO PLAY", 5)

    local farmStatusLbl = Instance.new("TextLabel")
    farmStatusLbl.Size = UDim2.new(1, -16, 0, 20)
    farmStatusLbl.BackgroundTransparency = 1
    farmStatusLbl.Text = "Status: Idle"
    farmStatusLbl.TextColor3 = C_DIM
    farmStatusLbl.TextSize = 11
    farmStatusLbl.Font = Enum.Font.Gotham
    farmStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
    farmStatusLbl.LayoutOrder = 6
    farmStatusLbl.Parent = farmPage

    local function setFarmStatus(msg, color)
        farmStatusLbl.Text = "Status: " .. msg
        farmStatusLbl.TextColor3 = color or C_DIM
    end

    makeToggle(farmPage, "Auto Farm", "Rescue → Fix 5 Gens → Open Gate → Escape", 7, function(s)
        Settings.AutoFarm = s
        if s then
            setFarmStatus("Starting...", C_YELLOW)
            coroutine.wrap(function()
                while Settings.AutoFarm do
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then task.wait(1); continue end

                    -- Rescue hooked players
                    setFarmStatus("🔍 Scanning hooks...", C_YELLOW)
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not Settings.AutoFarm then break end
                        if obj.Name:lower():find("hook") and obj:IsA("BasePart") then
                            hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0,3,0))
                            setFarmStatus("🤝 Rescuing survivor...", C_YELLOW)
                            for _, remote in pairs(game:GetDescendants()) do
                                if remote:IsA("RemoteEvent") and remote.Name:lower():find("rescue") then
                                    pcall(function() remote:FireServer(obj) end)
                                end
                            end
                            task.wait(2.5)
                        end
                    end

                    -- Fix generators
                    local genFixed = 0
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not Settings.AutoFarm then break end
                        if genFixed >= 5 then break end
                        if (obj.Name:lower():find("generator") or obj.Name:lower():find("gen")) and obj:IsA("BasePart") then
                            hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0,3,2))
                            setFarmStatus("⚡ Repairing generator " .. genFixed+1 .. "/5...", C_YELLOW)
                            -- Fire repair remote
                            for _, remote in pairs(game:GetDescendants()) do
                                if remote:IsA("RemoteEvent") and (remote.Name:lower():find("repair") or remote.Name:lower():find("gen")) then
                                    pcall(function() remote:FireServer(obj) end)
                                end
                            end
                            task.wait(6)
                            genFixed += 1
                        end
                    end

                    -- Open gate & escape
                    if genFixed >= 5 then
                        setFarmStatus("🚪 Opening exit gate...", C_GREEN)
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not Settings.AutoFarm then break end
                            if (obj.Name:lower():find("gate") or obj.Name:lower():find("exit")) and obj:IsA("BasePart") then
                                hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0,3,0))
                                for _, remote in pairs(game:GetDescendants()) do
                                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("gate") or remote.Name:lower():find("door") or remote.Name:lower():find("open")) then
                                        pcall(function() remote:FireServer(obj) end)
                                    end
                                end
                                task.wait(22)
                                setFarmStatus("✅ Escaped! Waiting next round...", C_GREEN)
                                task.wait(15)
                                break
                            end
                        end
                    else
                        setFarmStatus("⚠️ Generators not found!", C_RED)
                        task.wait(5)
                    end
                    task.wait(2)
                end
                setFarmStatus("Stopped", C_DIM)
            end)()
        else
            setFarmStatus("Stopped", C_DIM)
        end
    end)

    -- ══════════════════════════════
    --     PLAYER TAB
    -- ══════════════════════════════

    local playerPage = tabPages["Player"]
    makeSection(playerPage, "SELECT PLAYER", 1)

    local selectedTarget = nil

    local selectedLbl = Instance.new("TextLabel")
    selectedLbl.Size = UDim2.new(1, -16, 0, 20)
    selectedLbl.BackgroundTransparency = 1
    selectedLbl.Text = "Selected: None"
    selectedLbl.TextColor3 = C_DIM
    selectedLbl.TextSize = 11
    selectedLbl.Font = Enum.Font.Gotham
    selectedLbl.TextXAlignment = Enum.TextXAlignment.Left
    selectedLbl.LayoutOrder = 2
    selectedLbl.Parent = playerPage

    local plListFrame = Instance.new("Frame")
    plListFrame.Size = UDim2.new(1, 0, 0, 160)
    plListFrame.BackgroundColor3 = C_CARD
    plListFrame.BorderSizePixel = 0
    plListFrame.LayoutOrder = 3
    plListFrame.Parent = playerPage
    Instance.new("UICorner", plListFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", plListFrame).Color = C_BORDER

    local plScroll = Instance.new("ScrollingFrame")
    plScroll.Size = UDim2.new(1, 0, 1, 0)
    plScroll.BackgroundTransparency = 1
    plScroll.BorderSizePixel = 0
    plScroll.ScrollBarThickness = 3
    plScroll.ScrollBarImageColor3 = C_RED
    plScroll.Parent = plListFrame

    local plLayout = Instance.new("UIListLayout")
    plLayout.SortOrder = Enum.SortOrder.LayoutOrder
    plLayout.Padding = UDim.new(0, 2)
    plLayout.Parent = plScroll

    local plPad = Instance.new("UIPadding")
    plPad.PaddingAll = UDim.new(0, 4)
    plPad.Parent = plScroll

    plLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        plScroll.CanvasSize = UDim2.new(0, 0, 0, plLayout.AbsoluteContentSize.Y + 8)
    end)

    local function refreshPlayers()
        for _, v in pairs(plScroll:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p == player then continue end
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 32)
            btn.BackgroundColor3 = C_DARKRED
            btn.BackgroundTransparency = 0.5
            btn.Text = "👤 " .. p.Name
            btn.TextColor3 = C_TEXT
            btn.TextSize = 12
            btn.Font = Enum.Font.Gotham
            btn.BorderSizePixel = 0
            btn.Parent = plScroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

            btn.MouseButton1Click:Connect(function()
                selectedTarget = p
                selectedLbl.Text = "Selected: " .. p.Name
                selectedLbl.TextColor3 = C_BRIGHTRED
                for _, b in pairs(plScroll:GetChildren()) do
                    if b:IsA("TextButton") then
                        b.BackgroundTransparency = 0.5
                        b.TextColor3 = C_TEXT
                    end
                end
                btn.BackgroundTransparency = 0
                btn.TextColor3 = C_WHITE
            end)
        end
    end

    refreshPlayers()

    makeSection(playerPage, "ACTIONS", 4)

    makeActionBtn(playerPage, "🔄 Refresh List", C_DARKRED, 5, refreshPlayers)

    makeActionBtn(playerPage, "🌀 Teleport to Player", C_RED, 6, function()
        if not selectedTarget then return end
        local char = player.Character
        local tChar = selectedTarget.Character
        if char and tChar then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local tHrp = tChar:FindFirstChild("HumanoidRootPart")
            if hrp and tHrp then
                hrp.CFrame = CFrame.new(tHrp.Position + Vector3.new(3, 0, 0))
            end
        end
    end)

    makeActionBtn(playerPage, "📌 Spectate Player", Color3.fromRGB(60, 0, 80), 7, function()
        if not selectedTarget then return end
        local tChar = selectedTarget.Character
        if tChar then
            camera.CameraType = Enum.CameraType.Follow
            camera.CameraSubject = tChar:FindFirstChildOfClass("Humanoid")
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
    makeSection(miscPage, "UTILITY", 1)

    makeToggle(miscPage, "Anti AFK", "Prevent auto-kick", 2, function(s)
        if s then
            local VU = game:GetService("VirtualUser")
            player.Idled:Connect(function()
                VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(0.5)
                VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end)

    makeToggle(miscPage, "FPS Boost", "Lower render quality", 3, function(s)
        settings().Rendering.QualityLevel = s and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end)

    makeSection(miscPage, "SERVER", 4)

    makeActionBtn(miscPage, "🔄 Server Hop", C_RED, 5, function()
        local ok, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(
                game:GetService("HttpService"):GetAsync(
                    "https://games.roproxy.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=25"
                )
            )
        end)
        if ok and data and data.data then
            for _, s in ipairs(data.data) do
                if s.id ~= game.JobId and s.playing < s.maxPlayers then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
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

    local function getClosestPlayer()
        local closest = nil
        local closestDist = Settings.AimbotFOV
        local center = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
        for _, p in pairs(Players:GetPlayers()) do
            if p == player then continue end
            local char = p.Character
            if not char then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local target = char:FindFirstChild(Settings.AimbotPart) or char:FindFirstChild("HumanoidRootPart")
            if not target then continue end
            local sp, onScreen = camera:WorldToScreenPoint(target.Position)
            if not onScreen then continue end
            local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = target
            end
        end
        return closest
    end

    local espDrawings = {}

    local function makeESPDraw(color)
        local box = Drawing.new("Square")
        box.Color = color; box.Thickness = 1.5; box.Filled = false; box.Visible = false

        local nameDraw = Drawing.new("Text")
        nameDraw.Color = color; nameDraw.Size = 13; nameDraw.Font = 2; nameDraw.Outline = true; nameDraw.Visible = false

        local distDraw = Drawing.new("Text")
        distDraw.Color = C_DIM; distDraw.Size = 11; distDraw.Font = 2; distDraw.Outline = true; distDraw.Visible = false

        return {box=box, name=nameDraw, dist=distDraw}
    end

    RunService.RenderStepped:Connect(function()
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        -- FOV circle
        fovCircle.Visible = Settings.Aimbot
        fovCircle.Radius = Settings.AimbotFOV
        fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

        -- Aimbot
        if Settings.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local target = Settings.StrongLock and Settings.LockedTarget or getClosestPlayer()
            if target and target.Parent then
                if Settings.StrongLock then Settings.LockedTarget = target end
                local sp = camera:WorldToScreenPoint(target.Position)
                local center = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                local delta = Vector2.new(sp.X, sp.Y) - center
                mousemoverel(delta.X * Settings.AimbotSmooth, delta.Y * Settings.AimbotSmooth)
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
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end

        -- Infinite Jump
        if Settings.InfiniteJump and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end

        -- ESP Players
        for _, p in pairs(Players:GetPlayers()) do
            if p == player then continue end
            if not espDrawings[p.Name] then
                espDrawings[p.Name] = makeESPDraw(Color3.fromRGB(255, 80, 80))
            end
            local d = espDrawings[p.Name]
            local pChar = p.Character
            local pHrp = pChar and pChar:FindFirstChild("HumanoidRootPart")
            local pHum = pChar and pChar:FindFirstChildOfClass("Humanoid")

            if Settings.ESPPlayer and pHrp and pHum and pHum.Health > 0 then
                local sp, onScreen = camera:WorldToScreenPoint(pHrp.Position)
                if onScreen then
                    local sf = 1 / (sp.Z * math.tan(math.rad(camera.FieldOfView/2)) * 2 / camera.ViewportSize.Y)
                    local bSize = Vector2.new(3.5*sf, 5.5*sf)
                    local bPos = Vector2.new(sp.X - bSize.X/2, sp.Y - bSize.Y/2)
                    d.box.Size = bSize; d.box.Position = bPos; d.box.Visible = true
                    d.name.Text = p.Name; d.name.Position = Vector2.new(sp.X, bPos.Y - 16); d.name.Visible = true
                    local dist = math.floor((pHrp.Position - (hrp and hrp.Position or Vector3.zero)).Magnitude)
                    d.dist.Text = dist.."m"; d.dist.Position = Vector2.new(sp.X, bPos.Y + bSize.Y + 2); d.dist.Visible = true
                else
                    d.box.Visible = false; d.name.Visible = false; d.dist.Visible = false
                end
            else
                d.box.Visible = false; d.name.Visible = false; d.dist.Visible = false
            end
        end

        -- Generator ESP
        if Settings.ESPGenerator then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():find("generator") and obj:IsA("BasePart") and not obj:FindFirstChild("_GESP") then
                    local tag = Instance.new("BoolValue"); tag.Name = "_GESP"; tag.Parent = obj
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0,90,0,30); bill.AlwaysOnTop = true; bill.Parent = obj
                    local l = Instance.new("TextLabel")
                    l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1
                    l.Text = "⚡ Generator"; l.TextColor3 = C_YELLOW
                    l.TextSize = 12; l.Font = Enum.Font.GothamBold; l.Parent = bill
                end
            end
        end

        -- Hook ESP
        if Settings.ESPHook then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:lower():find("hook") and obj:IsA("BasePart") and not obj:FindFirstChild("_HESP") then
                    local tag = Instance.new("BoolValue"); tag.Name = "_HESP"; tag.Parent = obj
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0,80,0,30); bill.AlwaysOnTop = true; bill.Parent = obj
                    local l = Instance.new("TextLabel")
                    l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1
                    l.Text = "🪝 Hook"; l.TextColor3 = Color3.fromRGB(255,100,100)
                    l.TextSize = 12; l.Font = Enum.Font.GothamBold; l.Parent = bill
                end
            end
        end

        -- Gate ESP
        if Settings.ESPGate then
            for _, obj in pairs(workspace:GetDescendants()) do
                if (obj.Name:lower():find("gate") or obj.Name:lower():find("exit")) and obj:IsA("BasePart") and not obj:FindFirstChild("_EESP") then
                    local tag = Instance.new("BoolValue"); tag.Name = "_EESP"; tag.Parent = obj
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0,100,0,30); bill.AlwaysOnTop = true; bill.Parent = obj
                    local l = Instance.new("TextLabel")
                    l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1
                    l.Text = "🚪 Exit Gate"; l.TextColor3 = C_GREEN
                    l.TextSize = 12; l.Font = Enum.Font.GothamBold; l.Parent = bill
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
            Size = minimized and UDim2.new(0,580,0,46) or UDim2.new(0,580,0,420)
        }):Play()
    end)

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0,0,0,0),
            Position = UDim2.new(0.5,0,0.5,0)
        }):Play()
        task.wait(0.25)
        fovCircle:Remove()
        for _, d in pairs(espDrawings) do
            for _, v in pairs(d) do pcall(function() v:Remove() end) end
        end
        screenGui:Destroy()
    end)

    switchTab("Combat", tabs["Combat"])
    print("💀 H4ll0 W0rld | Violence District Pro v2.1 — LOADED")
end

-- ══════════════════════════════
--     VERIFY KEY
-- ══════════════════════════════

local function verifyKey(input)
    if input == VALID_KEY then
        -- Success
        keyStatusLbl.TextColor3 = C_GREEN
        keyStatusLbl.Text = "✅ Key verified!"
        verifyBtn.Text = "✅ Loading..."
        TweenService:Create(verifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,120,40)}):Play()
        TweenService:Create(keyInputStroke, TweenInfo.new(0.2), {Color = C_GREEN}):Play()
        lockIcon.Text = "🔓"

        task.wait(0.8)

        -- Animate out
        TweenService:Create(overlay, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(keyFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.4)
        keyGui:Destroy()
        loadMainScript()
    else
        -- Wrong key
        keyStatusLbl.TextColor3 = C_BRIGHTRED
        keyStatusLbl.Text = "❌ Wrong key! Get the correct one below."
        verifyBtn.Text = "🔓 Verify Key"
        TweenService:Create(verifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120,0,0)}):Play()
        task.wait(0.15)
        TweenService:Create(verifyBtn, TweenInfo.new(0.2), {BackgroundColor3 = C_RED}):Play()
        coroutine.wrap(flashWrong)()
        shakeKeyFrame()
        keyInput.Text = ""
    end
end

verifyBtn.MouseButton1Click:Connect(function()
    verifyKey(keyInput.Text)
end)

keyInput.FocusLost:Connect(function(enter)
    if enter then verifyKey(keyInput.Text) end
end)
