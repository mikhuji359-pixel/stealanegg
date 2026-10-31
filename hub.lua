-- ==============================================================================
--  MK HUB V4 PRO - ZENA MASTER SCRIPT EDITION (FULL CODE & 100% INDONESIA)
--  Asset ID Background: 124909014870452
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. KAMUS TERJEMAHAN MASTER BAHASA INDONESIA ====================
local currentLanguage = "ID"
local FastCache = {}
local updateNoticeLanguage = nil

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

local EXACT_MATCH_ID = {
    ["Chilli Hub"] = "MK Hub V4 Pro",
    ["Chilli Hub V4 Pro"] = "MK Hub V4 Pro",
    ["Hop"] = "Ganti Server",
    ["Join"] = "Masuk Ruangan",
    ["Copy"] = "Salin Tautan",
    ["Rejoin"] = "Gabung Ulang",
    ["Add"] = "Tambah",
    ["Sell"] = "Jual",
    ["Favorite"] = "Favoritkan",
    ["Unfavorite"] = "Batal Favorit",
    ["RESET"] = "ATUR ULANG",
    ["All"] = "Semua",
    ["ALL"] = "SEMUA",
    ["Any"] = "Bebas",
    ["None"] = "Tidak Ada",
    ["Off"] = "Mati",
    ["OFF"] = "MATI",
    ["On"] = "Hidup",
    ["ON"] = "HIDUP",
    ["Idle"] = "Santai",
    ["IDLE"] = "SANTAI",
    ["Stand"] = "Berdiri",
    ["Chase"] = "Kejar",
    ["Circle"] = "Melingkar",
    ["Patrol"] = "Patroli",
    ["Rarest"] = "Paling Langka",
    ["Nearest"] = "Paling Dekat",
    ["Always"] = "Selalu",
    ["Never"] = "Jangan Pernah",
    ["Value"] = "Nilai",
    ["Cosmic"] = "Kosmik (Cosmic)",
    ["Divine"] = "Ilahi (Divine)",
    ["Eternal"] = "Abadi (Eternal)",
    ["Mythic"] = "Mitis (Mythic)",
    ["Legendary"] = "Legendaris",
    ["Epic"] = "Epik",
    ["Rare"] = "Langka",
    ["Uncommon"] = "Tidak Biasa",
    ["Common"] = "Umum",
    ["Secret"] = "Rahasia",
    ["Least Players"] = "Pemain Paling Sedikit",
    ["Steal Then Hop"] = "Curi Lalu Ganti Server",
    ["Rarity Only"] = "Hanya Berdasarkan Kelangkaan",
    ["Rarity And Value"] = "Kelangkaan & Nilai",
    ["Value Only"] = "Hanya Berdasarkan Nilai",
    ["Lowest Rarity First"] = "Kelangkaan Terendah Dulu",
    ["Lowest To Highest"] = "Dari Rendah ke Tinggi",
    ["Highest To Lowest"] = "Dari Tinggi ke Rendah",
    ["Match All"] = "Cocokkan Semua",
    ["Match Any"] = "Cocokkan Apa Saja",
    ["Highest Value"] = "Nilai Tertinggi",
    ["Lowest Value"] = "Nilai Terendah",

    -- Panel Rebranding
    ["Venyx"] = "MK Panel",
    ["Try now"] = "Coba Sekarang",
    ["Smoother, faster and more ways to steal."] = "Lebih mulus, cepat, dan banyak cara mencuri.",
    ["Less lag, quick to load."] = "Minim lag, cepat dimuat.",
    ["More steal methods"] = "Banyak Metode Pencurian",
    ["Steal from players"] = "Curi dari Pemain Lain",
    ["Hits whoever takes your egg"] = "Serang siapa pun yang mengambil telurmu.",
    ["Easy setup"] = "Pengaturan Mudah",
    ["Bring your Chilli config"] = "Gunakan konfigurasi MK Anda.",
    ["Filter features..."] = "Saring fitur...",

    -- Event & Halloween
    ["HALLOWEEN"] = "HALLOWEEN",
    ["Halloween"] = "Halloween",
    ["HALLOWEEN DIMENSION"] = "DIMENSI HALLOWEEN",
    ["Halloween Dimension"] = "Dimensi Halloween",
    ["Auto steal Halloween eggs"] = "Otomatis curi telur Halloween",
    ["Instant steal Halloween eggs"] = "Curi instan telur Halloween",
    ["Steal speed"] = "Kecepatan curi",
    ["Halloween eggs"] = "Telur Halloween",
    ["Halloween rarities"] = "Kelangkaan Halloween",
    ["Auto Pumpkin Moon"] = "Otomatis Pumpkin Moon",
    ["Pumpkin Moon"] = "Pumpkin Moon",
    ["MONSTERS"] = "MONSTER",
    ["Monsters"] = "Monster",
    ["Auto farm monsters"] = "Otomatis serang monster",
    ["Monster order"] = "Urutan monster",
    ["Use weapons"] = "Gunakan Senjata",
    ["Racing Bat"] = "Tongkat Pemukul Balap",
    ["PHANTOM EXPRESS"] = "KERETA HANTU",
    ["Phantom Express"] = "Kereta Hantu",
    ["TRAIN"] = "KERETA",
    ["Train"] = "Kereta",
    ["SOULS"] = "JIWA",
    ["Souls"] = "Jiwa",
    ["Not here"] = "Tidak di sini",
    ["Walk speed"] = "Kecepatan Jalan",
    ["Event"] = "Acara Khusus",
    ["Shooting Star"] = "Bintang Jatuh",
    ["Butterfly Bloom"] = "Taman Kupu-Kupu"
}

local MAP_ID = {
    ["Chilli Hub"] = "MK Hub",
    ["Farm"] = "Pertanian",
    ["Player"] = "Pemain",
    ["Predictor"] = "Peramal",
    ["Progress"] = "Progres",
    ["Server"] = "Server",
    ["Misc"] = "Lainnya",
    ["Auto Hop"] = "Ganti Server Otomatis",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Pintasan & Kunci",
    ["Settings"] = "Pengaturan",
    ["Config"] = "Konfigurasi",
    ["Search"] = "Pencarian",
    
    ["Instant Steal"] = "Pencurian Instan",
    ["Auto Hatch"] = "Otomatis Menetas",
    ["Auto Sell"] = "Otomatis Jual",
    ["Auto Equip Best"] = "Otomatis Pakai Terbaik",
    ["Combat"] = "Pertarungan",
    ["Movement"] = "Pergerakan",
    ["Utility"] = "Utilitas",
    ["ESP"] = "ESP (Tembus Pandang)"
}

local SortedID = {}
for en, idText in pairs(MAP_ID) do table.insert(SortedID, {en = en, out = idText, len = #en}) end
table.sort(SortedID, function(a, b) return a.len > b.len end)

-- ==================== 2. CORE TRANSLATION ENGINE ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    local trimmed = raw:match("^%s*(.-)%s*$") or raw
    if EXACT_MATCH_ID[trimmed] then
        local res = raw:gsub(trimmed, EXACT_MATCH_ID[trimmed], 1)
        FastCache[cacheKey] = res
        return res
    end

    local result = raw
    local matched = false

    for _, item in ipairs(SortedID) do
        if result:find(item.en, 1, true) then
            result = replaceAll(result, item.en, item.out)
            matched = true
        end
    end

    FastCache[cacheKey] = matched and result or raw
    return FastCache[cacheKey]
end

local TrackedElements = {}

local function applyTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("MK_Liquid_Capsule") or inst:FindFirstAncestor("MK_Rainbow_Notice") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    local original = inst:GetAttribute("OriginalRawText")
    if not original then
        original = inst.Text
        inst:SetAttribute("OriginalRawText", original)
    end

    local mappedText = translateText(original)
    if inst.Text ~= mappedText then
        inst:SetAttribute("__IsTranslating", true)
        inst:SetAttribute("__LastTranslatedText", mappedText)
        pcall(function() inst.Text = mappedText end)
        inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("HasTranslateHook") then return end
    inst:SetAttribute("HasTranslateHook", true)

    table.insert(TrackedElements, inst)
    task.defer(function() applyTranslation(inst) end)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") then return end
        local current = inst.Text
        if current == inst:GetAttribute("__LastTranslatedText") then return end
        inst:SetAttribute("OriginalRawText", current)
        applyTranslation(inst)
    end)
end

-- ==================== 3. BACKGROUND INJECTOR & ZENA UI ====================
local function applyCustomBackground(mainFrame)
    if not mainFrame then return end
    local bgImg = mainFrame:FindFirstChild("MK_CustomBackground")
    if not bgImg then
        bgImg = Instance.new("ImageLabel")
        bgImg.Name = "MK_CustomBackground"
        bgImg.Size = UDim2.new(1, 0, 1, 0)
        bgImg.Position = UDim2.new(0, 0, 0, 0)
        bgImg.BackgroundTransparency = 1
        BgImage = "rbxassetid://124909014870452"
        bgImg.Image = BgImage
        bgImg.ImageTransparency = 0.22 -- Keseimbangan grafis & teks
        bgImg.ScaleType = Enum.ScaleType.Slice
        bgImg.ZIndex = 0
        bgImg.Parent = mainFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = bgImg
    end
end

-- ==================== 4. MODAL PELANGI NOTIFIKASI MK HUB ====================
local function createRainbowNoticeUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local oldNotice = parentTarget:FindFirstChild("MK_Rainbow_Notice")
    if oldNotice then oldNotice:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MK_Rainbow_Notice"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483646
    ScreenGui.Parent = parentTarget

    local Card = Instance.new("Frame")
    Card.Name = "Card"
    Card.Size = UDim2.new(0, 380, 0, 200)
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.new(0.5, 0, 0.5, 0)
    Card.BackgroundColor3 = Color3.fromRGB(12, 15, 24)
    Card.BorderSizePixel = 0
    Card.Parent = ScreenGui

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 16)
    CardCorner.Parent = Card

    applyCustomBackground(Card)

    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 3.2
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Card

    local RainbowGrad = Instance.new("UIGradient")
    RainbowGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 45, 85)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 235, 45)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 210, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(185, 45, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 45, 85))
    })
    RainbowGrad.Parent = Stroke

    local rotOffset = 0
    local rotConn = RunService.RenderStepped:Connect(function()
        if RainbowGrad and RainbowGrad.Parent then
            rotOffset = (rotOffset + 1.5) % 360
            RainbowGrad.Rotation = rotOffset
        end
    end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 30)
    Title.Position = UDim2.new(0, 20, 0, 25)
    Title.BackgroundTransparency = 1
    Title.Text = "MK Hub V4 Pro"
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = Card

    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(1, -40, 0, 60)
    Message.Position = UDim2.new(0, 20, 0, 65)
    Message.BackgroundTransparency = 1
    Message.Text = "Script MK Hub V4 Pro (Full Edisi Bahasa Indonesia) berhasil dimuat dengan latar belakang kustom Anda!"
    Message.Font = Enum.Font.GothamMedium
    Message.TextSize = 12
    Message.TextColor3 = Color3.fromRGB(210, 225, 245)
    Message.TextWrapped = true
    Message.Parent = Card

    local ConfirmBtn = Instance.new("TextButton")
    ConfirmBtn.Size = UDim2.new(1, -40, 0, 38)
    ConfirmBtn.Position = UDim2.new(0, 20, 1, -52)
    ConfirmBtn.BackgroundColor3 = Color3.fromRGB(45, 110, 200)
    ConfirmBtn.BorderSizePixel = 0
    ConfirmBtn.Text = "MENGERTI"
    ConfirmBtn.Font = Enum.Font.GothamBold
    ConfirmBtn.TextSize = 13
    ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmBtn.Parent = Card

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = ConfirmBtn

    ConfirmBtn.MouseButton1Click:Connect(function()
        if rotConn then rotConn:Disconnect() end
        ScreenGui:Destroy()
    end)
end

-- ==================== 5. SISTEM PEMINDAI UI OTOMATIS ====================
task.delay(2, function()
    createRainbowNoticeUI()

    local searchRoots = { gethui and gethui(), CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }

    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
            end
            if i % 35 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then pcall(function() scanUIChunked(root) end) end
    end

    for _, root in ipairs(searchRoots) do
        if root then
            root.DescendantAdded:Connect(function(desc)
                task.defer(function()
                    if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                        hookElement(desc)
                    end
                end)
            end)
        end
    end
end)

print("MK Hub V4 Pro Master Script (Full Indo + Custom Asset ID: 124909014870452) Berjalan Sukses!")
