-- ==============================================================================
--  MK HUB V4 PRO - ZENA MASTER EDITION (100% INDONESIA & FULL CODE)
--  Asset ID Background: 124909014870452
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP SCRIPT CHILLI HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== 2. TỪ ĐIỂN DỊCH THUẬT MASTER (100% INDONESIA) ====================
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
    ["Cosmic"] = "Kosmik",
    ["Divine"] = "Ilahi",
    ["Eternal"] = "Abadi",
    ["Mythic"] = "Mitis",
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
    ["3 - Rare"] = "3 - Langka",
    ["6 - Mythic"] = "6 - Mitis",
    ["EGGS"] = "TELUR",
    ["READY"] = "SIAP",
    ["GROWING"] = "TUMBUH",
    ["IN BAG"] = "DALAM TAS",
    ["TOTAL / S"] = "TOTAL / DETIK",
    ["SCRAMBLED"] = "TERDIKSI",
    ["GOLDEN"] = "KEEMASAN",
    ["SILVER"] = "PERAK",
    ["RAINBOW"] = "PELANGI",

    -- ==================== MK PANEL (ex-Venyx) ====================
    ["Venyx"] = "MK Panel",
    ["Try now"] = "Coba Sekarang",
    ["Smoother, faster and more ways to steal."] = "Lebih mulus, cepat, dan banyak cara mencuri.",
    ["✓ Smoother & faster"] = "✓ Lebih mulus & cepat",
    ["Smoother & faster"] = "Lebih mulus & cepat",
    ["Less lag, quick to load."] = "Minim lag, cepat dimuat.",
    ["✓ More steal methods"] = "✓ Banyak metode pencurian",
    ["More steal methods"] = "Banyak metode pencurian",
    ["Teleport, Fast tween and..."] = "Teleportasi, Tween cepat, dan lainnya.",
    ["✓ Steal from players"] = "✓ Curi dari pemain lain",
    ["Steal from players"] = "Curi dari pemain lain",
    ["Hits whoever takes your egg"] = "Serang siapa saja yang mengambil telurmu.",
    ["✓ Easy setup"] = "✓ Pengaturan mudah",
    ["Easy setup"] = "Pengaturan mudah",
    ["Bring your Chilli config"] = "Gunakan konfigurasi MK Anda.",
    ["Filter features..."] = "Saring fitur...",

    -- ==================== HALLOWEEN EVENT ====================
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
    ["Auto farm monsters"] = "Otomatis farm monster",
    ["Monster order"] = "Urutan monster",
    ["Use weapons"] = "Gunakan senjata",
    ["Racing Bat"] = "Tongkat Balap",
    ["PHANTOM EXPRESS"] = "KERETA HANTU",
    ["Phantom Express"] = "Kereta Hantu",
    ["TRAIN"] = "KERETA",
    ["Train"] = "Kereta",
    ["SOULS"] = "JIWA",
    ["Souls"] = "Jiwa",
    ["Not here"] = "Tidak di sini",
    ["Walk speed"] = "Kecepatan jalan",
    ["Event"] = "Acara",
    ["Sao Băng"] = "Bintang Jatuh",
    ["Bắt Bướm"] = "Tangkap Kupu-kupu"
}

local MAP_ID = {
    ["Chilli Hub"] = "MK Hub V4 Pro",
    ["Farm"] = "Pertanian",
    ["Player"] = "Pemain",
    ["Predictor"] = "Peramal",
    ["Progress"] = "Progres",
    ["Server"] = "Server",
    ["Misc"] = "Lainnya",
    ["Auto Hop"] = "Ganti Server Otomatis",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Pintasan & Tombol",
    ["Settings"] = "Pengaturan",
    ["Config"] = "Konfigurasi",
    ["Filter features..."] = "Saring fitur...",
    ["Search"] = "Pencarian",

    ["Venyx"] = "MK Panel",
    ["Try now"] = "Coba Sekarang",
    ["Racing Event"] = "Acara Balap",
    ["Auto Race"] = "Otomatis Balap",
    ["Auto Claim Race Rewards"] = "Klaim Hadiah Balap Otomatis",
    ["Auto Equip Racer"] = "Pakai Pembalap Otomatis",
    ["Racer"] = "Pembalap",
    ["Auto Buy Race Shop"] = "Beli Toko Balap Otomatis",
    ["Race Shop Items"] = "Item Toko Balap",
    ["Admin Abuse"] = "Penyalahgunaan Admin",
    ["Shooting Star"] = "Bintang Jatuh",
    ["Auto Catch Shooting Star"] = "Tangkap Bintang Jatuh Otomatis",
    ["Instant Steal V2"] = "Curi Instan V2",

    ["Dr Scramble Lab & Mech"] = "Laboratorium Dr. Scramble & Mech",
    ["Dr Scramble Lab"] = "Laboratorium Dr. Scramble",
    ["Butterfly Bloom"] = "Taman Kupu-kupu",
    ["Wisp Companion"] = "Pendamping Wisp",
    ["Auto Steal"] = "Otomatis Curi",
    ["Auto Place Egg"] = "Otomatis Letakkan Telur",
    ["Auto Treadmill"] = "Otomatis Treadmill",
    ["Auto Hatch & Equip"] = "Otomatis Menetas & Pakai",
    ["Auto Sell"] = "Otomatis Jual",
    ["Auto Sell Pet"] = "Otomatis Jual Pet",
    ["Auto Sell Egg"] = "Otomatis Jual Telur",
    ["Auto Sell Lab Egg"] = "Otomatis Jual Telur Lab",
    ["Auto Fuse Machine"] = "Mesin Fusi Otomatis",
    ["Auto Favorite"] = "Otomatis Favoritkan",
    ["Priority"] = "Prioritas",
    ["ESP"] = "ESP",
    ["Movement"] = "Pergerakan",
    ["Character"] = "Karakter",
    ["Combat"] = "Pertarungan",
    ["Discord Webhook"] = "Webhook Discord",
    ["Egg Predictor"] = "Peramal Telur",
    ["Lab Predictor"] = "Peramal Lab",
    ["Fuse Predictor"] = "Peramal Fusi",
    ["Auto Progression"] = "Progres Otomatis",
    ["Performance"] = "Performa",
    ["Utility"] = "Utilitas",
    ["Egg Finder"] = "Pencari Telur",
    ["Quick Bar 1"] = "Bilah Cepat 1",
    ["Quick Bar 2"] = "Bilah Cepat 2",

    ["Instant Steal"] = "Curi Instan",
    ["Auto Hatch"] = "Otomatis Menetas",
    ["Auto Buy Trail"] = "Beli Jejak Otomatis",
    ["Auto Upgrade Base"] = "Tingkatkan Markas Otomatis",
    ["Auto Upgrade Treadmill"] = "Tingkatkan Treadmill Otomatis",
    ["Auto Claim"] = "Klaim Otomatis",
    ["Auto Claim Index"] = "Klaim Indeks Otomatis",
    ["Server Hop"] = "Ganti Server",
    ["Anti AFK"] = "Anti AFK"
}

local SortedID = {}
for en, idText in pairs(MAP_ID) do table.insert(SortedID, {en = en, out = idText, len = #en}) end
table.sort(SortedID, function(a, b) return a.len > b.len end)

-- ==================== 3. LÕI DỊCH THUẬT SIÊU TỐC O(1) ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        local res = replaceAll(raw, "MK Hub", "MK Hub V4 Pro")
        res = replaceAll(res, "MK Panel", "MK Panel")
        FastCache[cacheKey] = res
        return res
    end

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

local function updateAllActive()
    for i = #TrackedElements, 1, -1 do
        local el = TrackedElements[i]
        if el and el.Parent then
            applyTranslation(el)
        else
            table.remove(TrackedElements, i)
        end
    end
end

-- ==================== 4. HỆ THỐNG ZENA UI & ẢNH NỀN TÙY CHỈNH (124909014870452) ====================
local function applyCustomBackground(mainFrame)
    if not mainFrame then return end
    local bgImg = mainFrame:FindFirstChild("MK_CustomBackground")
    if not bgImg then
        bgImg = Instance.new("ImageLabel")
        bgImg.Name = "MK_CustomBackground"
        bgImg.Size = UDim2.new(1, 0, 1, 0)
        bgImg.Position = UDim2.new(0, 0, 0, 0)
        bgImg.BackgroundTransparency = 1
        bgImg.Image = "rbxassetid://124909014870452"
        bgImg.ImageTransparency = 0.25
        bgImg.ScaleType = Enum.ScaleType.Slice
        bgImg.ZIndex = 0
        bgImg.Parent = mainFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = bgImg
    end
end

local COLOR_FACE_TOP    = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW= Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["pertanian"] = true, ["farm"] = true,
    ["pemain"] = true, ["player"] = true,
    ["peramal"] = true, ["predictor"] = true,
    ["progres"] = true, ["progress"] = true,
    ["server"] = true,
    ["lainnya"] = true, ["misc"] = true,
    ["ganti server otomatis"] = true, ["auto hop"] = true,
    ["discord"] = true,
    ["pintasan & tombol"] = true, ["quick & keys"] = true,
    ["pengaturan"] = true, ["settings"] = true,
    ["konfigurasi"] = true, ["config"] = true
}

local function recolorSingleButton(btnContainer, labelObj)
    if not btnContainer then return end
    
    local grad = btnContainer:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = btnContainer
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })

    btnContainer.BackgroundColor3 = COLOR_FACE_BOTTOM

    if btnContainer.Parent and btnContainer.Parent:IsA("Frame") and btnContainer.Parent ~= btnContainer then
        local p = btnContainer.Parent
        local pCol = p.BackgroundColor3
        if pCol and (pCol.R > 0.4 and pCol.G < 0.35) then
            p.BackgroundColor3 = COLOR_BEVEL_SHADOW
        end
    end

    if labelObj and (labelObj:IsA("TextLabel") or labelObj:IsA("TextButton")) then
        labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function recolorHeaderBar(headerFrame, titleObj)
    if not headerFrame then return end

    local grad = headerFrame:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Rotation = 90
        grad.Parent = headerFrame
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
        ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
    })

    headerFrame.BackgroundColor3 = COLOR_FACE_BOTTOM

    if headerFrame.Parent and headerFrame.Parent:IsA("Frame") then
        local p = headerFrame.Parent
        if p.BackgroundColor3.R > 0.4 and p.BackgroundColor3.G < 0.35 then
            p.BackgroundColor3 = COLOR_BEVEL_SHADOW
        end
    end

    if titleObj and (titleObj:IsA("TextLabel") or titleObj:IsA("TextButton")) then
        titleObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    for _, item in ipairs(headerFrame:GetDescendants()) do
        if item:IsA("TextButton") or item:IsA("ImageButton") then
            item.BackgroundColor3 = COLOR_FACE_BOTTOM
            local xGrad = item:FindFirstChildOfClass("UIGradient")
            if xGrad then
                xGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, COLOR_FACE_TOP),
                    ColorSequenceKeypoint.new(1, COLOR_FACE_BOTTOM)
                })
            end
            if item:IsA("TextButton") then
                item.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end

local function inspectAndApplySoftBlue(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("MK_Liquid_Capsule") or inst:FindFirstAncestor("MK_Rainbow_Notice") then return end

    local textRaw = inst.Text:lower():match("^%s*(.-)%s*$") or ""

    if textRaw:find("mk hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then
            recolorHeaderBar(headerFrame, inst)
            applyCustomBackground(headerFrame.Parent)
        end
        return
    end

    if TARGET_BUTTON_KEYWORDS[textRaw] then
        local btnTarget = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton") or inst:FindFirstAncestorOfClass("Frame")
        if btnTarget then
            recolorSingleButton(btnTarget, inst)
        end
        return
    end
end

-- ==================== 5. BẢNG THÔNG BÁO XỊN XÒ VIỀN CẦU VỒNG (RAINBOW MODAL) ====================
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
    Card.Size = UDim2.new(0, 370, 0, 195)
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
        ColorSequenceKeypoint.new(0.08, Color3.fromRGB(255, 95, 40)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 175, 35)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 235, 45)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(140, 255, 55)),
        ColorSequenceKeypoint.new(0.42, Color3.fromRGB(40, 245, 130)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 210, 255)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(45, 140, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(110, 70, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(185, 45, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 40, 200)),
        ColorSequenceKeypoint.new(0.92, Color3.fromRGB(255, 50, 120)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 45, 85))
    })
    RainbowGrad.Parent = Stroke

    local rotOffset = 0
    local rotConn = RunService.RenderStepped:Connect(function(dt)
        if RainbowGrad and RainbowGrad.Parent then
            rotOffset = (rotOffset + 1.4 + math.sin(os.clock() * 1.8) * 0.35) % 360
            RainbowGrad.Rotation = rotOffset
        end
    end)

    local Badge = Instance.new("Frame")
    Badge.Size = UDim2.new(0, 180, 0, 24)
    Badge.Position = UDim2.new(0.5, -90, 0, 14)
    Badge.BackgroundColor3 = Color3.fromRGB(24, 30, 48)
    Badge.BorderSizePixel = 0
    Badge.Parent = Card

    local BadgeCorner = Instance.new("UICorner")
    BadgeCorner.CornerRadius = UDim.new(1, 0)
    BadgeCorner.Parent = Badge

    local BadgeStroke = Instance.new("UIStroke")
    BadgeStroke.Thickness = 1
    BadgeStroke.Color = Color3.fromRGB(70, 120, 200)
    BadgeStroke.Parent = Badge

    local BadgeLabel = Instance.new("TextLabel")
    BadgeLabel.Size = UDim2.new(1, 0, 1, 0)
    BadgeLabel.BackgroundTransparency = 1
    BadgeLabel.Text = "🛠️ PEMBERITAHUAN PEMBARUAN"
    BadgeLabel.Font = Enum.Font.GothamBold
    BadgeLabel.TextSize = 10
    BadgeLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    BadgeLabel.Parent = Badge

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 26)
    Title.Position = UDim2.new(0, 20, 0, 44)
    Title.BackgroundTransparency = 1
    Title.Text = "MK Hub V4 Pro"
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = Card

    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(1, -36, 0, 52)
    Message.Position = UDim2.new(0, 18, 0, 74)
    Message.BackgroundTransparency = 1
    Message.Text = "Skrip MK Hub V4 Pro siap digunakan!"
    Message.Font = Enum.Font.GothamMedium
    Message.TextSize = 12
    Message.TextColor3 = Color3.fromRGB(200, 215, 235)
    Message.TextWrapped = true
    Message.Parent = Card

    local ConfirmBtn = Instance.new("TextButton")
    ConfirmBtn.Size = UDim2.new(1, -40, 0, 36)
    ConfirmBtn.Position = UDim2.new(0, 20, 1, -48)
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

    local BtnGradient = Instance.new("UIGradient")
    BtnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 150, 245)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 95, 185))
    })
    BtnGradient.Rotation = 90
    BtnGradient.Parent = ConfirmBtn

    updateNoticeLanguage = function(lang)
        if lang == "ID" then
            BadgeLabel.Text = "🛠️ PEMBERITAHUAN PEMBARUAN"
            Message.Text = "Skrip MK Hub V4 Pro siap digunakan!"
            ConfirmBtn.Text = "MENGERTI"
        else
            BadgeLabel.Text = "🛠️ UPDATE NOTICE"
            Message.Text = "MK Hub V4 Pro script is ready to use!"
            ConfirmBtn.Text = "UNDERSTOOD"
        end
    end

    ConfirmBtn.MouseButton1Click:Connect(function()
        if rotConn then rotConn:Disconnect() end
        local fadeTween = TweenService:Create(Card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.55, 0),
            BackgroundTransparency = 1
        })
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TweenService:Create(Message, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(Title, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(ConfirmBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        TweenService:Create(Badge, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(BadgeLabel, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
end

-- ==================== 6. NÚT ĐỔI NGÔN NGỮ LIQUID CYBER ====================
local function createLiquidCapsuleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("MK_Liquid_Capsule")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MK_Liquid_Capsule"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Capsule = Instance.new("Frame")
    Capsule.Name = "Capsule"
    Capsule.Size = UDim2.new(0, 176, 0, 36)
    Capsule.AnchorPoint = Vector2.new(0.5, 0)
    Capsule.Position = UDim2.new(0.5, 0, 0, 12)
    Capsule.BackgroundColor3 = Color3.fromRGB(12, 16, 24)
    Capsule.BackgroundTransparency = 0.15
    Capsule.BorderSizePixel = 0
    Capsule.Parent = ScreenGui

    local CapsuleCorner = Instance.new("UICorner")
    CapsuleCorner.CornerRadius = UDim.new(1, 0)
    CapsuleCorner.Parent = Capsule

    local CapsuleStroke = Instance.new("UIStroke")
    CapsuleStroke.Thickness = 1.4
    CapsuleStroke.Color = COLOR_FACE_TOP
    CapsuleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    CapsuleStroke.Parent = Capsule

    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Size = UDim2.new(0, 84, 0, 28)
    Slider.Position = UDim2.new(0, 4, 0.5, -14)
    Slider.BackgroundColor3 = COLOR_FACE_BOTTOM
    Slider.BorderSizePixel = 0
    Slider.Parent = Capsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = Slider

    local BtnID = Instance.new("TextButton")
    BtnID.Name = "BtnID"
    BtnID.Size = UDim2.new(0, 84, 1, 0)
    BtnID.Position = UDim2.new(0, 4, 0, 0)
    BtnID.BackgroundTransparency = 1
    BtnID.Text = "🇮🇩 INDONESIA"
    BtnID.Font = Enum.Font.GothamBold
    BtnID.TextSize = 10
    BtnID.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnID.ZIndex = 5
    BtnID.Parent = Capsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Name = "BtnEN"
    BtnEN.Size = UDim2.new(0, 84, 1, 0)
    BtnEN.Position = UDim2.new(1, -88, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(145, 160, 185)
    BtnEN.ZIndex = 5
    BtnEN.Parent = Capsule

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target

        if target == "ID" then
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 4, 0.5, -14),
                BackgroundColor3 = COLOR_FACE_BOTTOM
            }):Play()
            TweenService:Create(BtnID, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        else
            TweenService:Create(Slider, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -88, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(55, 70, 95)
            }):Play()
            TweenService:Create(BtnEN, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(BtnID, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(145, 160, 185)}):Play()
        end

        updateAllActive()
        if updateNoticeLanguage then
            updateNoticeLanguage(target)
        end
    end

    BtnID.MouseButton1Click:Connect(function() switchMode("ID") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)
end

-- ==================== 7. MK PANEL (ex-Venyx) OVERRIDE ====================
local MK_PANEL_LOADSTRING = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/napun87/stealanegg/refs/heads/main/ChilliHub_V6_Pro0.lua"))()'
local OLD_VENYX_URL_SNIPPET = "tienkhanh1/Venyx"
local TryNowHooked = {}

local function isTryNowButton(inst)
    if not inst:IsA("TextButton") then return false end
    local t = (inst.Text or ""):lower():match("^%s*(.-)%s*$") or ""
    return t == "try now" or t == "coba sekarang" or t:find("try now") or t:find("coba sekarang")
end

local function overrideTryNow(btn)
    if not btn or TryNowHooked[btn] then return end
    TryNowHooked[btn] = true

    pcall(function()
        for _, conn in ipairs(getconnections and getconnections(btn.MouseButton1Click) or {}) do
            pcall(function() conn:Disconnect() end)
            pcall(function() conn:Disable() end)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/ChilliV5BaKhi.lua"))()
        end)
    end)
end

local function patchMKPanelElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:FindFirstAncestor("MK_Liquid_Capsule") or inst:FindFirstAncestor("MK_Rainbow_Notice") then return end

    local raw = inst.Text or ""

    if raw:find(OLD_VENYX_URL_SNIPPET, 1, true) or (raw:find("loadstring", 1, true) and raw:find("VenyxHub", 1, true)) then
        if inst.Text ~= MK_PANEL_LOADSTRING then
            inst:SetAttribute("__IsTranslating", true)
            pcall(function() inst.Text = MK_PANEL_LOADSTRING end)
            inst:SetAttribute("OriginalRawText", MK_PANEL_LOADSTRING)
            inst:SetAttribute("__LastTranslatedText", MK_PANEL_LOADSTRING)
            inst:SetAttribute("__IsTranslating", false)
        end
    end

    if isTryNowButton(inst) then
        overrideTryNow(inst)
    end
end

-- ==================== 8. BỘ QUÉT TẢI TRÌ HOÃN (DEFER SCANNER) ====================
task.delay(2.5, function()
    createRainbowNoticeUI()
    createLiquidCapsuleUI()

    local searchRoots = {
        gethui and gethui(),
        CoreGui,
        LocalPlayer:FindFirstChild("PlayerGui")
    }

    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
                inspectAndApplySoftBlue(desc)
                patchMKPanelElement(desc)
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
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
                        inspectAndApplySoftBlue(desc)
                        patchMKPanelElement(desc)
                    end
                end)
            end)
        end
    end

    task.delay(3, function()
        for _, root in ipairs(searchRoots) do
            if root then pcall(function() scanUIChunked(root) end) end
        end
    end)
    task.delay(6, function()
        for _, root in ipairs(searchRoots) do
            if root then pcall(function() scanUIChunked(root) end) end
        end
    end)
end)
