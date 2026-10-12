local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

math.randomseed(tick())

local Config = {
    Title = "SCRIPTING404",
    Subtitle = "SECURE SESSION",
    Accent = Color3.fromRGB(238, 240, 246),
    Secondary = Color3.fromRGB(128, 134, 148),
    Backdrop = Color3.fromRGB(8, 9, 13),
    BackdropTransparency = 0.45,
    BlurSize = 20,
    LogoCount = 3,
    LogoHold = 1.0,
}

local GRID = 17
local CENTER = 9
local FORM_TIME = 1.2
local ICONS_URL = "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

local Ease = Enum.EasingStyle
local Dir = Enum.EasingDirection

local DisplayName = LocalPlayer.DisplayName
local UserName = LocalPlayer.Name

local Chars = {"0", "1", "{", "}", "<", ">", "/", ";", "#", "$", "%", "&", "*", "+", "=", "|"}
local ScrambleChars = {}
for c in ("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&*+=<>/"):gmatch(".") do
    ScrambleChars[#ScrambleChars + 1] = c
end

local Phrases = {
    "Welcome back, {name}",
    "Good to see you again",
    "Systems online and ready",
    "Initializing your session",
    "Let's get this started",
    "Access granted",
    "Everything is in place",
    "Locked in and loaded",
    "Hello again, {name}",
    "Booting up the interface",
    "Your session is secure",
    "Ready when you are",
    "Powering up the engine",
    "Syncing your profile",
    "Another day, another script",
    "Welcome to the grid",
    "Calibrating the interface",
    "Stay sharp, {name}",
    "Let the show begin",
    "Warming up the core",
    "Nice to have you here",
    "All modules standing by",
    "Entering the matrix",
    "Compiling good vibes",
    "The stage is yours, {name}",
}

local hour = tonumber(os.date("%H")) or 12
if hour < 12 then
    Phrases[#Phrases + 1] = "Good morning, {name}"
elseif hour < 18 then
    Phrases[#Phrases + 1] = "Good afternoon, {name}"
else
    Phrases[#Phrases + 1] = "Good evening, {name}"
end

local StatusMessages = {"Initializing modules", "Verifying session", "Syncing assets", "Loading interface", "Finalizing"}
local StatusIcons = {"cpu", "shield-check", "download", "layout-dashboard", "check-check"}

local Shapes = {
    roblox = function(u, v)
        local a = math.rad(-14)
        local ru = u * math.cos(a) - v * math.sin(a)
        local rv = u * math.sin(a) + v * math.cos(a)
        local m = math.max(math.abs(ru), math.abs(rv))
        return m <= 6.3 and m > 2.0
    end,
    lua = function(u, v)
        local bu, bv = u + 0.8, v - 0.8
        local bd = math.sqrt(bu * bu + bv * bv)
        local su, sv = u - 5.6, v + 5.6
        local sd = math.sqrt(su * su + sv * sv)
        return (bd <= 6.5 and not (bd >= 3.3 and bd <= 4.5)) or sd <= 2.0
    end,
    cyber = function(u, v)
        local h = math.max(math.abs(u) * 0.866 + math.abs(v) * 0.5, math.abs(v))
        local d = math.abs(u) + math.abs(v)
        return (h <= 6.9 and h > 5.0) or d <= 2.4
    end,
    code = function(u, v)
        local left = u >= -7 and u <= -2 and math.abs(math.abs(v) - (u + 7)) <= 1.01
        local right = u >= 2 and u <= 7 and math.abs(math.abs(v) - (7 - u)) <= 1.01
        local slash = math.abs(v) <= 6 and math.abs(u + v * 0.25) <= 0.9
        return left or right or slash
    end,
}
local ShapeNames = {"roblox", "lua", "cyber", "code"}

local function new(class, props, parent)
    local inst = Instance.new(class)
    for key, value in pairs(props) do
        inst[key] = value
    end
    inst.Parent = parent
    return inst
end

local function tween(inst, time, props, style, direction)
    local t = TweenService:Create(inst, TweenInfo.new(time, style or Ease.Quint, direction or Dir.Out), props)
    t:Play()
    return t
end

local function shuffled(list)
    local copy = {}
    for i, v in ipairs(list) do
        copy[i] = v
    end
    for i = #copy, 2, -1 do
        local j = math.random(1, i)
        copy[i], copy[j] = copy[j], copy[i]
    end
    return copy
end

local function splitChars(text)
    local out = {}
    for _, code in utf8.codes(text) do
        out[#out + 1] = utf8.char(code)
    end
    return out
end

local function resolveHost()
    if gethui then
        local ok, ui = pcall(gethui)
        if ok and ui then
            return ui
        end
    end
    local ok = pcall(function()
        return CoreGui:GetChildren()
    end)
    if ok then
        return CoreGui
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function clearOld(container)
    for _, child in ipairs(container:GetChildren()) do
        if child.Name == "S404Intro" or child.Name == "S404IntroBlur" then
            child:Destroy()
        end
    end
end

local Host = resolveHost()
clearOld(Host)
clearOld(Lighting)

local Gui = new("ScreenGui", {
    Name = "S404Intro",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = 999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, nil)
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(Gui)
    end
end)
Gui.Parent = Host

local Blur = new("BlurEffect", {Name = "S404IntroBlur", Size = 0}, Lighting)
tween(Blur, 0.9, {Size = Config.BlurSize}, Ease.Sine)

local Dim = new("Frame", {
    Name = "Dim",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Config.Backdrop,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 1,
}, Gui)
tween(Dim, 0.8, {BackgroundTransparency = Config.BackdropTransparency}, Ease.Sine)

local Icons = nil
local iconRequests = {}

local function applyIcon(label, name)
    local ok, icon = pcall(Icons.GetIcon, name)
    if not ok or not icon then
        return
    end
    if type(icon) == "table" then
        local image = icon.Image or icon[1]
        local size = icon.ImageRectSize or icon[2]
        local pos = icon.ImageRectPosition or icon[3]
        if image then
            label.Image = image
        end
        if size then
            label.ImageRectSize = size
        end
        if pos then
            label.ImageRectPosition = pos
        end
    else
        label.Image = icon
    end
end

local function setIcon(label, name)
    iconRequests[label] = name
    if Icons then
        applyIcon(label, name)
    end
end

task.spawn(function()
    local ok, lib = pcall(function()
        local okGet, src = pcall(function()
            return game:HttpGetAsync(ICONS_URL)
        end)
        if not okGet then
            src = game:HttpGet(ICONS_URL)
        end
        return loadstring(src)()
    end)
    if ok and lib then
        Icons = lib
        pcall(function()
            Icons.SetIconsType("lucide")
        end)
        for label, name in pairs(iconRequests) do
            if label.Parent then
                applyIcon(label, name)
            end
        end
    end
end)

local SpeedValue = Instance.new("NumberValue")
SpeedValue.Value = 8
local speedTween = nil

local function setSpeed(from, to, time)
    if speedTween then
        speedTween:Cancel()
    end
    SpeedValue.Value = from
    speedTween = tween(SpeedValue, time, {Value = to}, Ease.Quad, Dir.Out)
end

local Fx = new("Frame", {
    Name = "Fx",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 2,
}, Gui)

local lines = {}
for i = 1, 36 do
    local len = math.random(14, 42) / 100
    local thick = math.random(1, 2)
    local frame = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(len, 0, 0, thick),
        BackgroundColor3 = (i % 3 == 0) and Config.Accent or Config.Secondary,
        BackgroundTransparency = math.random(25, 65) / 100,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, Fx)
    new("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0),
        }),
    }, frame)
    lines[i] = {
        frame = frame,
        len = len,
        thick = thick,
        x = math.random() * 1.4 - 0.2,
        y = math.random(),
        speed = math.random(60, 160) / 100,
    }
end

local rain = {}
for i = 1, 16 do
    local buf = {}
    for j = 1, 26 do
        buf[j] = Chars[math.random(1, #Chars)]
    end
    local label = new("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.fromOffset(14, 312),
        BackgroundTransparency = 1,
        Text = table.concat(buf, "\n"),
        Font = Enum.Font.Code,
        TextSize = 12,
        TextColor3 = Config.Secondary,
        TextTransparency = 0.78,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 2,
    }, Fx)
    rain[i] = {
        label = label,
        x = (i - 0.5) / 16 + (math.random() - 0.5) * 0.03,
        y = -math.random() * 1.2,
        speed = math.random(15, 40) / 100,
    }
end

local Content = new("Frame", {
    Name = "Content",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.92, 0.78),
    BackgroundTransparency = 1,
    ZIndex = 5,
}, Gui)
new("UIAspectRatioConstraint", {
    AspectRatio = 2.3,
    AspectType = Enum.AspectType.FitWithinMaxSize,
    DominantAxis = Enum.DominantAxis.Width,
}, Content)
new("UISizeConstraint", {MaxSize = Vector2.new(920, 400)}, Content)
local ContentScale = new("UIScale", {Scale = 1}, Content)

local function corner(ax, ay)
    local holder = new("Frame", {
        AnchorPoint = Vector2.new(ax, ay),
        Position = UDim2.fromScale(ax, ay),
        Size = UDim2.fromOffset(18, 18),
        BackgroundTransparency = 1,
        ZIndex = 6,
    }, Content)
    local h = new("Frame", {
        AnchorPoint = Vector2.new(ax, ay),
        Position = UDim2.fromScale(ax, ay),
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = Config.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
    }, holder)
    local v = new("Frame", {
        AnchorPoint = Vector2.new(ax, ay),
        Position = UDim2.fromScale(ax, ay),
        Size = UDim2.new(0, 2, 1, 0),
        BackgroundColor3 = Config.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
    }, holder)
    tween(h, 0.8, {BackgroundTransparency = 0.35}, Ease.Sine)
    tween(v, 0.8, {BackgroundTransparency = 0.35}, Ease.Sine)
end
corner(0, 0)
corner(1, 0)
corner(0, 1)
corner(1, 1)

local LogoHolder = new("Frame", {
    Name = "LogoHolder",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.2, 0.5),
    Size = UDim2.fromScale(0.36, 0.9),
    BackgroundTransparency = 1,
    ZIndex = 6,
}, Content)
new("UIAspectRatioConstraint", {AspectRatio = 1}, LogoHolder)

local Separator = new("Frame", {
    Name = "Separator",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.405, 0.5),
    Size = UDim2.new(0, 1, 0, 0),
    BackgroundColor3 = Config.Accent,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 6,
}, Content)
new("UIGradient", {
    Rotation = 90,
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
    }),
}, Separator)

local Info = new("Frame", {
    Name = "Info",
    Position = UDim2.fromScale(0.42, 0.1),
    Size = UDim2.fromScale(0.58, 0.8),
    BackgroundTransparency = 1,
    ZIndex = 6,
}, Content)

local AvatarHolder = new("Frame", {
    Name = "AvatarHolder",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.15, 0.25),
    Size = UDim2.fromScale(0.3, 0.5),
    BackgroundTransparency = 1,
    ZIndex = 7,
}, Info)
new("UIAspectRatioConstraint", {AspectRatio = 1}, AvatarHolder)
local AvatarScale = new("UIScale", {Scale = 0}, AvatarHolder)

local Ring = new("Frame", {
    Name = "Ring",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 7,
}, AvatarHolder)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, Ring)
local RingStroke = new("UIStroke", {
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 3,
    Transparency = 1,
}, Ring)
local RingGradient = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Accent),
        ColorSequenceKeypoint.new(0.5, Config.Secondary),
        ColorSequenceKeypoint.new(1, Config.Accent),
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.85),
        NumberSequenceKeypoint.new(1, 0),
    }),
}, RingStroke)

local AvatarImage = new("ImageLabel", {
    Name = "Avatar",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(0.84, 0.84),
    BackgroundColor3 = Color3.fromRGB(24, 25, 31),
    BackgroundTransparency = 1,
    ImageTransparency = 1,
    Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420", LocalPlayer.UserId),
    ZIndex = 8,
}, AvatarHolder)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, AvatarImage)

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({AvatarImage})
    end)
end)

local DisplayLabel = new("TextLabel", {
    Name = "DisplayName",
    Position = UDim2.fromScale(0.31, 0.04),
    Size = UDim2.fromScale(0.66, 0.22),
    BackgroundTransparency = 1,
    Text = "",
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    TextColor3 = Config.Accent,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 34, MinTextSize = 6}, DisplayLabel)

local UserLabel = new("TextLabel", {
    Name = "Username",
    Position = UDim2.fromScale(0.31, 0.27),
    Size = UDim2.fromScale(0.66, 0.12),
    BackgroundTransparency = 1,
    Text = "@" .. UserName,
    TextScaled = true,
    Font = Enum.Font.Gotham,
    TextColor3 = Config.Secondary,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 20, MinTextSize = 6}, UserLabel)

local MetaLabel = new("TextLabel", {
    Name = "Meta",
    Position = UDim2.fromScale(0.31, 0.42),
    Size = UDim2.fromScale(0.66, 0.08),
    BackgroundTransparency = 1,
    Text = "ID " .. tostring(LocalPlayer.UserId) .. "  |  AGE " .. tostring(LocalPlayer.AccountAge) .. "d",
    TextScaled = true,
    Font = Enum.Font.Code,
    TextColor3 = Config.Secondary,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 14, MinTextSize = 5}, MetaLabel)

local GreetIcon = new("ImageLabel", {
    Name = "GreetIcon",
    Position = UDim2.fromScale(0, 0.585),
    Size = UDim2.fromScale(0.06, 0.1),
    BackgroundTransparency = 1,
    ImageColor3 = Config.Accent,
    ImageTransparency = 1,
    ZIndex = 8,
}, Info)
new("UIAspectRatioConstraint", {AspectRatio = 1}, GreetIcon)
setIcon(GreetIcon, "zap")

local GreetingLabel = new("TextLabel", {
    Name = "Greeting",
    Position = UDim2.fromScale(0.075, 0.57),
    Size = UDim2.fromScale(0.925, 0.14),
    BackgroundTransparency = 1,
    Text = "",
    TextScaled = true,
    Font = Enum.Font.Code,
    TextColor3 = Config.Accent,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 24, MinTextSize = 6}, GreetingLabel)

local StatusIcon = new("ImageLabel", {
    Name = "StatusIcon",
    Position = UDim2.fromScale(0, 0.795),
    Size = UDim2.fromScale(0.045, 0.07),
    BackgroundTransparency = 1,
    ImageColor3 = Config.Secondary,
    ImageTransparency = 1,
    ZIndex = 8,
}, Info)
new("UIAspectRatioConstraint", {AspectRatio = 1}, StatusIcon)
setIcon(StatusIcon, StatusIcons[1])

local StatusLabel = new("TextLabel", {
    Name = "Status",
    Position = UDim2.fromScale(0.06, 0.78),
    Size = UDim2.fromScale(0.62, 0.1),
    BackgroundTransparency = 1,
    Text = StatusMessages[1],
    TextScaled = true,
    Font = Enum.Font.Code,
    TextColor3 = Config.Secondary,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 14, MinTextSize = 5}, StatusLabel)

local PercentLabel = new("TextLabel", {
    Name = "Percent",
    Position = UDim2.fromScale(0.75, 0.78),
    Size = UDim2.fromScale(0.25, 0.1),
    BackgroundTransparency = 1,
    Text = "0%",
    TextScaled = true,
    Font = Enum.Font.Code,
    TextColor3 = Config.Accent,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextTransparency = 1,
    ZIndex = 8,
}, Info)
new("UITextSizeConstraint", {MaxTextSize = 14, MinTextSize = 5}, PercentLabel)

local Track = new("Frame", {
    Name = "Track",
    Position = UDim2.fromScale(0, 0.91),
    Size = UDim2.fromScale(1, 0.035),
    BackgroundColor3 = Color3.fromRGB(44, 46, 54),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 8,
}, Info)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, Track)

local Fill = new("Frame", {
    Name = "Fill",
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = Config.Accent,
    BorderSizePixel = 0,
    ZIndex = 9,
}, Track)
new("UICorner", {CornerRadius = UDim.new(1, 0)}, Fill)
new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Secondary),
        ColorSequenceKeypoint.new(1, Config.Accent),
    }),
}, Fill)

local Tag = new("Frame", {
    Name = "Tag",
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.fromScale(0.5, 0.965),
    Size = UDim2.fromOffset(0, 18),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundTransparency = 1,
    ZIndex = 6,
}, Gui)
new("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Tag)
local TagIcon = new("ImageLabel", {
    Size = UDim2.fromOffset(16, 16),
    BackgroundTransparency = 1,
    ImageColor3 = Config.Secondary,
    ImageTransparency = 1,
    LayoutOrder = 1,
    ZIndex = 6,
}, Tag)
setIcon(TagIcon, "terminal")
local TagLabel = new("TextLabel", {
    Size = UDim2.fromOffset(0, 16),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundTransparency = 1,
    Text = Config.Title .. "  //  " .. Config.Subtitle,
    Font = Enum.Font.Code,
    TextSize = 13,
    TextColor3 = Config.Secondary,
    TextTransparency = 1,
    LayoutOrder = 2,
    ZIndex = 6,
}, Tag)
tween(TagIcon, 0.8, {ImageTransparency = 0.2}, Ease.Sine)
tween(TagLabel, 0.8, {TextTransparency = 0.2}, Ease.Sine)

local running = true
local lastPercent = -1
local statusIndex = 0

local stepConn = RunService.RenderStepped:Connect(function(dt)
    local boost = SpeedValue.Value
    for _, l in ipairs(lines) do
        l.x = l.x + l.speed * boost * dt
        local width = l.len * (0.55 + boost * 0.12)
        if l.x > 1 then
            l.x = -width
            l.y = math.random()
        end
        l.frame.Size = UDim2.new(width, 0, 0, l.thick)
        l.frame.Position = UDim2.fromScale(l.x, l.y)
    end
    for _, r in ipairs(rain) do
        r.y = r.y + r.speed * dt * (0.6 + boost * 0.25)
        if r.y > 1 then
            r.y = -1.2
        end
        r.label.Position = UDim2.fromScale(r.x, r.y)
    end
    RingGradient.Rotation = (RingGradient.Rotation + dt * 220) % 360
    local p = math.clamp(math.floor(Fill.Size.X.Scale * 100 + 0.5), 0, 100)
    if p ~= lastPercent then
        lastPercent = p
        PercentLabel.Text = tostring(p) .. "%"
        local idx = math.clamp(math.floor(p / 20) + 1, 1, #StatusMessages)
        if idx ~= statusIndex then
            statusIndex = idx
            StatusLabel.Text = StatusMessages[idx]
            setIcon(StatusIcon, StatusIcons[idx])
        end
    end
end)

local function flash(alpha)
    local f = new("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Config.Accent,
        BackgroundTransparency = alpha or 0.86,
        BorderSizePixel = 0,
        ZIndex = 4,
    }, Gui)
    tween(f, 0.45, {BackgroundTransparency = 1}, Ease.Sine)
    task.delay(0.5, function()
        f:Destroy()
    end)
end

local function scan()
    local s = new("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.fromScale(0, 0),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0,
        ZIndex = 10,
    }, LogoHolder)
    new("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1, 1),
        }),
    }, s)
    tween(s, 0.7, {Position = UDim2.fromScale(0, 1)}, Ease.Sine, Dir.InOut)
    task.delay(0.8, function()
        s:Destroy()
    end)
end

local function shimmer(state)
    while state.alive and running do
        for _ = 1, 6 do
            local c = state.cells[math.random(1, #state.cells)]
            if c and c.label.Parent then
                c.label.Text = Chars[math.random(1, #Chars)]
                c.label.TextColor3 = Color3.fromRGB(255, 255, 255)
                tween(c.label, 0.35, {TextColor3 = c.color}, Ease.Sine)
            end
        end
        task.wait(0.07)
    end
end

local function buildLogo(shape)
    local fn = Shapes[shape]
    local state = {alive = true, cells = {}}
    for y = 1, GRID do
        for x = 1, GRID do
            if fn(x - CENTER, y - CENTER) then
                local color = (math.random() < 0.6) and Config.Accent or Config.Secondary
                local label = new("TextLabel", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.fromScale(1 / GRID, 1 / GRID),
                    Position = UDim2.fromScale(math.random(-250, -40) / 100, math.random(-40, 140) / 100),
                    BackgroundTransparency = 1,
                    Text = Chars[math.random(1, #Chars)],
                    TextScaled = true,
                    Font = Enum.Font.Code,
                    TextColor3 = color,
                    TextTransparency = 1,
                    ZIndex = 9,
                }, LogoHolder)
                state.cells[#state.cells + 1] = {label = label, color = color}
                local delay = ((x + y) / (GRID * 2)) * 0.5 + math.random() * 0.2
                task.delay(delay, function()
                    if not label.Parent then
                        return
                    end
                    tween(label, 0.45 + math.random() * 0.1, {
                        Position = UDim2.fromScale((x - 0.5) / GRID, (y - 0.5) / GRID),
                        TextTransparency = 0,
                    }, Ease.Quint, Dir.Out)
                end)
            end
        end
    end
    task.spawn(shimmer, state)
    return state
end

local function dissolve(state)
    state.alive = false
    for _, cell in ipairs(state.cells) do
        local label = cell.label
        local pos = label.Position
        task.delay(math.random() * 0.2, function()
            if not label.Parent then
                return
            end
            tween(label, 0.5, {
                Position = UDim2.fromScale(pos.X.Scale + math.random(150, 300) / 100, pos.Y.Scale + math.random(-20, 20) / 100),
                TextTransparency = 1,
            }, Ease.Quad, Dir.In)
        end)
        task.delay(1, function()
            label:Destroy()
        end)
    end
end

local function reveal(label, text, duration)
    if label.TextTransparency > 0 then
        tween(label, 0.25, {TextTransparency = 0}, Ease.Sine)
    end
    local chars = splitChars(text)
    local n = #chars
    local steps = math.max(n * 2, 16)
    for i = 1, steps do
        local shown = math.floor(n * i / steps)
        local buf = {}
        for j = 1, n do
            if j <= shown or chars[j] == " " then
                buf[j] = chars[j]
            else
                buf[j] = ScrambleChars[math.random(1, #ScrambleChars)]
            end
        end
        label.Text = table.concat(buf)
        task.wait(duration / steps)
    end
    label.Text = text
end

local function pulses()
    while running do
        local p = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 7,
        }, AvatarHolder)
        new("UICorner", {CornerRadius = UDim.new(1, 0)}, p)
        local stroke = new("UIStroke", {Color = Config.Accent, Thickness = 2, Transparency = 0.4}, p)
        tween(p, 1.4, {Size = UDim2.fromScale(1.35, 1.35)}, Ease.Quad, Dir.Out)
        tween(stroke, 1.4, {Transparency = 1}, Ease.Quad, Dir.Out)
        task.delay(1.5, function()
            p:Destroy()
        end)
        task.wait(0.9)
    end
end

local function revealProfile(fillTime)
    tween(Separator, 0.7, {Size = UDim2.new(0, 1, 0.72, 0), BackgroundTransparency = 0.5}, Ease.Quint)
    tween(AvatarScale, 0.7, {Scale = 1}, Ease.Back, Dir.Out)
    tween(RingStroke, 0.5, {Transparency = 0}, Ease.Sine)
    tween(AvatarImage, 0.5, {ImageTransparency = 0, BackgroundTransparency = 0}, Ease.Sine)
    task.spawn(pulses)
    task.wait(0.25)
    tween(DisplayLabel, 0.4, {TextTransparency = 0, Position = UDim2.fromScale(0.34, 0.04)}, Ease.Quint)
    task.spawn(reveal, DisplayLabel, DisplayName, 0.6)
    task.wait(0.2)
    tween(UserLabel, 0.4, {TextTransparency = 0.1, Position = UDim2.fromScale(0.34, 0.27)}, Ease.Quint)
    task.wait(0.12)
    tween(MetaLabel, 0.4, {TextTransparency = 0.2, Position = UDim2.fromScale(0.34, 0.42)}, Ease.Quint)
    tween(GreetIcon, 0.4, {ImageTransparency = 0}, Ease.Sine)
    tween(StatusIcon, 0.4, {ImageTransparency = 0.2}, Ease.Sine)
    tween(StatusLabel, 0.4, {TextTransparency = 0.2}, Ease.Sine)
    tween(PercentLabel, 0.4, {TextTransparency = 0}, Ease.Sine)
    tween(Track, 0.4, {BackgroundTransparency = 0.25}, Ease.Sine)
    tween(Fill, fillTime, {Size = UDim2.fromScale(1, 1)}, Ease.Linear, Dir.InOut)
end

local function fadeOut()
    for _, d in ipairs(Content:GetDescendants()) do
        if d.Parent ~= LogoHolder then
            if d:IsA("TextLabel") then
                tween(d, 0.5, {TextTransparency = 1}, Ease.Sine)
            elseif d:IsA("ImageLabel") then
                tween(d, 0.5, {ImageTransparency = 1, BackgroundTransparency = 1}, Ease.Sine)
            elseif d:IsA("Frame") then
                tween(d, 0.5, {BackgroundTransparency = 1}, Ease.Sine)
            elseif d:IsA("UIStroke") then
                tween(d, 0.5, {Transparency = 1}, Ease.Sine)
            end
        end
    end
    tween(TagIcon, 0.5, {ImageTransparency = 1}, Ease.Sine)
    tween(TagLabel, 0.5, {TextTransparency = 1}, Ease.Sine)
    for _, l in ipairs(lines) do
        tween(l.frame, 0.6, {BackgroundTransparency = 1}, Ease.Sine)
    end
    for _, r in ipairs(rain) do
        tween(r.label, 0.6, {TextTransparency = 1}, Ease.Sine)
    end
end

local function sequence()
    setSpeed(8, 1.6, 1.6)
    task.wait(0.3)

    local pool = shuffled(ShapeNames)
    local order = {}
    for i = 1, Config.LogoCount do
        order[i] = pool[((i - 1) % #pool) + 1]
    end

    local phrasePool = shuffled(Phrases)
    local phrases = {}
    for i = 1, #order do
        local raw = phrasePool[((i - 1) % #phrasePool) + 1]
        phrases[i] = (raw:gsub("{name}", function()
            return DisplayName
        end))
    end

    local cycle = FORM_TIME + 0.15 + Config.LogoHold
    local total = #order * cycle
    local state = nil

    for i, shape in ipairs(order) do
        if state then
            setSpeed(6, 1.6, 1.0)
            dissolve(state)
            task.wait(0.15)
        end
        state = buildLogo(shape)
        task.wait(FORM_TIME)
        flash()
        scan()
        if i == 1 then
            task.spawn(revealProfile, math.max(total - FORM_TIME - 0.4, 2))
        end
        task.spawn(reveal, GreetingLabel, phrases[i], 0.6)
        task.wait(Config.LogoHold)
    end

    setSpeed(9, 2.5, 1.0)
    flash(0.8)
    if state then
        dissolve(state)
    end
    fadeOut()
    tween(ContentScale, 0.7, {Scale = 1.12}, Ease.Quad, Dir.In)
    task.wait(0.35)
    tween(Dim, 0.7, {BackgroundTransparency = 1}, Ease.Sine)
    tween(Blur, 0.7, {Size = 0}, Ease.Sine)
    task.wait(0.85)
end

pcall(sequence)

running = false
stepConn:Disconnect()
SpeedValue:Destroy()
Blur:Destroy()
Gui:Destroy()