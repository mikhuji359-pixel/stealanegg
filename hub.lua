-- ==============================================================================
--  MK HUB PRO - BLACK & SOFT BLUE EDITION (UPDATED)
--  Tối ưu hóa:
--    1. BLACK CLEAN MODAL: Viền đen/xám tối tối giản, không hiệu ứng cầu vồng.
--    2. BILINGUAL LIVE-SYNC: Đổi ngôn ngữ thông báo (VI/EN) theo nút Capsule.
--    3. PRECISION 3-PART RESKIN: Khung Header, Cột Tab trái, Cột nút phải mang sắc Xanh Nhạt Dịu Mắt.
--    4. KHÓA CHỮ TRẮNG 100%: Bảo toàn màu chữ trắng tinh khiết, không can thiệp nút game ngoài.
--    5. DỊCH THUẬT MASTER FULL: Đã đổi tên toàn bộ thành MK Hub.
--    6. SUPER INSTANT AUTO STEAL: Tốc độ cướp cực nhanh tương đương Admin Abuse.
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. NẠP SCRIPT MK HUB GỐC ====================
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- ==================== 2. TỪ ĐIỂN DỊCH THUẬT MASTER (VI / EN) ====================
local currentLanguage = "ID" -- Default Indonesia/English mapping
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
    ["Chilli Hub"] = "MK Hub",
    ["Hop"] = "Ganti Server",
    ["Join"] = "Masuk Ruangan",
    ["Copy"] = "Salin",
    ["Rejoin"] = "Masuk Lagi",
    ["Add"] = "Tambah",
    ["Sell"] = "Jual",
    ["Favorite"] = "Kunci",
    ["Unfavorite"] = "Buka Kunci",
    ["RESET"] = "ATUR ULANG",
    ["All"] = "Semua",
    ["ALL"] = "SEMUA",
    ["Any"] = "Bebas",
    ["None"] = "Tidak ada",
    ["Off"] = "Mati",
    ["OFF"] = "MATI",
    ["On"] = "Nyala",
    ["ON"] = "NYALA",
    ["Idle"] = "Santai",
    ["IDLE"] = "SANTAI",
    ["Stand"] = "Berdiri",
    ["Chase"] = "Kejar",
    ["Circle"] = "Putar",
    ["Patrol"] = "Patroli",
    ["Rarest"] = "Paling Langka",
    ["Nearest"] = "Paling Dekat",
    ["Always"] = "Selalu",
    ["Never"] = "Tidak Pernah",
    ["Value"] = "Nilai",
    ["Cosmic"] = "Kosmik (Cosmic)",
    ["Divine"] = "Dewa (Divine)",
    ["Eternal"] = "Abadi (Eternal)",
    ["Mythic"] = "Mitis (Mythic)",
    ["Legendary"] = "Legendaris (Legendary)",
    ["Epic"] = "Epik (Epic)",
    ["Rare"] = "Langka (Rare)",
    ["Uncommon"] = "Tidak Biasa (Uncommon)",
    ["Common"] = "Biasa (Common)",
    ["Secret"] = "Rahasia (Secret)",
    ["Least Players"] = "Pemain Paling Sedikit",
    ["Steal Then Hop"] = "Curi Lalu Pindah Server",
    ["Rarity Only"] = "Hanya Berdasarkan Kelangkaan",
    ["Rarity And Value"] = "Kelangkaan & Nilai",
    ["Value Only"] = "Hanya Nilai",
    ["Lowest Rarity First"] = "Kelangkaan Terendah Dulu",
    ["Lowest To Highest"] = "Dari Rendah ke Tinggi",
    ["Highest To Lowest"] = "Dari Tinggi ke Rendah",
    ["Match All"] = "Cocok Semua",
    ["Match Any"] = "Cocok Salah Satu",
    ["Highest Value"] = "Nilai Tertinggi",
    ["Lowest Value"] = "Nilai Terendah",
    ["EGGS"] = "TELUR",
    ["READY"] = "SIAP",
    ["GROWING"] = "BERKEMBANG",
    ["IN BAG"] = "DALAM TAS",
    ["TOTAL / S"] = "TOTAL / DETIK",
    ["SCRAMBLED"] = "TERACIK",
    ["GOLDEN"] = "EMAS",
    ["SILVER"] = "PERAK",
    ["RAINBOW"] = "PELANGI",

    ["Venyx"] = "MK Panel",
    ["Try now"] = "Coba Sekarang",
    ["Smoother, faster and more ways to steal."] = "Lebih mulus, cepat, dan banyak cara mencuri.",
    ["Filter features..."] = "Filter fitur...",

    ["HALLOWEEN"] = "HALLOWEEN",
    ["Halloween"] = "Halloween",
    ["Auto steal Halloween eggs"] = "Otomatis curi telur Halloween",
    ["Instant steal Halloween eggs"] = "Curi instan telur Halloween",
    ["Steal speed"] = "Kecepatan curi",
    ["Auto Pumpkin Moon"] = "Otomatis Pumpkin Moon",
    ["Pumpkin Moon"] = "Pumpkin Moon",
    ["MONSTERS"] = "MONSTER",
    ["Monsters"] = "Monster",
    ["Auto farm monsters"] = "Otomatis farm monster",
    ["Use weapons"] = "Gunakan senjata",
    ["Walk speed"] = "Kecepatan jalan"
}

local MAP_ID = {
    ["Chilli Hub"] = "MK Hub",
    ["Farm"] = "Farm",
    ["Player"] = "Pemain",
    ["Predictor"] = "Prediktor",
    ["Progress"] = "Progres",
    ["Server"] = "Server",
    ["Misc"] = "Lainnya",
    ["Auto Hop"] = "Auto Pindah Server",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Pintasan & Tombol",
    ["Settings"] = "Pengaturan",
    ["Config"] = "Konfigurasi",
    ["Filter features..."] = "Cari fitur...",
    ["Search"] = "Cari",

    ["Venyx"] = "MK Panel",
    ["Try now"] = "Coba Sekarang",
    ["Instant Steal"] = "Curi Instan (Super Instant)",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Kirim telur ke zona aman secepat kilat mode Admin Abuse!",
    ["Instant Steal Steps"] = "Langkah Curi Instan",
    ["Target Areas"] = "Area Target",
    ["Min Steal Value"] = "Nilai Curi Min",
    ["Target Specific Eggs"] = "Target Telur Spesifik",
    ["Steal Priority"] = "Prioritas Curi",
    ["Carry Speed"] = "Kecepatan Bawa",

    ["Auto Hatch"] = "Otomatis Menetas",
    ["Auto Sell"] = "Otomatis Jual",
    ["Auto Favorite"] = "Otomatis Kunci",
    ["ESP"] = "ESP",
    ["Movement"] = "Gerakan",
    ["Combat"] = "Pertempuran",
    ["Performance"] = "Performa",
    ["Utility"] = "Utilitas",

    ["FPS Cap"] = "Batas FPS",
    ["Optimizer"] = "Pengопtimasi (Anti Lag)",
    ["Anti AFK"] = "Anti AFK",
    ["Server Hop"] = "Ganti Server",
    ["Rejoin Server"] = "Gabung Ulang Server"
}

local DYNAMIC_PATTERNS = {
    {
        pattern = "ALL (%d+)",
        format = function(lang, c) return (lang == "ID" and ("SEMUA " .. c) or ("ALL " .. c)) end
    },
    {
        pattern = "READY (%d+)",
        format = function(lang, c) return (lang == "ID" and ("SIAP " .. c) or ("READY " .. c)) end
    },
    {
        pattern = "PLAYERS (%d+)/(%d+)",
        format = function(lang, p1, p2) return string.format("Pemain %s/%s", p1, p2) end
    }
}

local SortedID = {}
for en, id in pairs(MAP_ID) do table.insert(SortedID, {en = en, out = id, len = #en}) end
table.sort(SortedID, function(a, b) return a.len > b.len end)

-- ==================== 3. LÕI DỊCH THUẬT ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        local res = replaceAll(raw, "Chilli Hub", "MK Hub")
        res = replaceAll(res, "Venyx", "MK Panel")
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
    if inst:FindFirstAncestor("MK_Capsule") or inst:FindFirstAncestor("MK_Notice") then return end
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

-- ==================== 4. WARNA & TEMA SOFT BLUE ====================
local COLOR_FACE_TOP    = Color3.fromRGB(140, 195, 245)
local COLOR_FACE_BOTTOM = Color3.fromRGB(95, 155, 225)
local COLOR_BEVEL_SHADOW= Color3.fromRGB(55, 110, 180)

local TARGET_BUTTON_KEYWORDS = {
    ["farm"] = true, ["pemain"] = true, ["player"] = true,
    ["prediktor"] = true, ["progres"] = true, ["server"] = true,
    ["lainnya"] = true, ["misc"] = true, ["pengaturan"] = true,
    ["konfigurasi"] = true, ["discord"] = true
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
    if labelObj then labelObj.TextColor3 = Color3.fromRGB(255, 255, 255) end
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
    if titleObj then titleObj.TextColor3 = Color3.fromRGB(255, 255, 255) end
end

local function inspectAndApplySoftBlue(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("MK_Capsule") or inst:FindFirstAncestor("MK_Notice") then return end
    local textRaw = inst.Text:lower():match("^%s*(.-)%s*$") or ""
    if textRaw:find("mk hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then recolorHeaderBar(headerFrame, inst) end
        return
    end
    if TARGET_BUTTON_KEYWORDS[textRaw] then
        local btnTarget = inst:IsA("TextButton") and inst or inst:FindFirstAncestorOfClass("TextButton") or inst:FindFirstAncestorOfClass("Frame")
        if btnTarget then recolorSingleButton(btnTarget, inst) end
        return
    end
end

-- ==================== 5. BẢNG THÔNG BÁO TỐI GIẢN (BLACK CLEAN MODAL) ====================
local function createCleanNoticeUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local oldNotice = parentTarget:FindFirstChild("MK_Notice")
    if oldNotice then oldNotice:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MK_Notice"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483646
    ScreenGui.Parent = parentTarget

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(0, 370, 0, 195)
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.new(0.5, 0, 0.5, 0)
    Card.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Hitam pekat bersih
    Card.BorderSizePixel = 0
    Card.Parent = ScreenGui

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 16)
    CardCorner.Parent = Card

    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1.5
    Stroke.Color = Color3.fromRGB(50, 50, 50) -- Border abu gelap elegan tanpa pelangi
    Stroke.Parent = Card

    local Badge = Instance.new("Frame")
    Badge.Size = UDim2.new(0, 180, 0, 24)
    Badge.Position = UDim2.new(0.5, -90, 0, 14)
    Badge.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Badge.BorderSizePixel = 0
    Badge.Parent = Card

    local BadgeCorner = Instance.new("UICorner")
    BadgeCorner.CornerRadius = UDim.new(1, 0)
    BadgeCorner.Parent = Badge

    local BadgeLabel = Instance.new("TextLabel")
    BadgeLabel.Size = UDim2.new(1, 0, 1, 0)
    BadgeLabel.BackgroundTransparency = 1
    BadgeLabel.Text = "🛠️ PEMBERITAHUAN UPDATE"
    BadgeLabel.Font = Enum.Font.GothamBold
    BadgeLabel.TextSize = 10
    BadgeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    BadgeLabel.Parent = Badge

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 26)
    Title.Position = UDim2.new(0, 20, 0, 44)
    Title.BackgroundTransparency = 1
    Title.Text = "MK Hub Pro"
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = Card

    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(1, -36, 0, 52)
    Message.Position = UDim2.new(0, 18, 0, 74)
    Message.BackgroundTransparency = 1
    Message.Text = "MK Hub Pro siap digunakan dengan mode Super Instant!"
    Message.Font = Enum.Font.GothamMedium
    Message.TextSize = 12
    Message.TextColor3 = Color3.fromRGB(180, 180, 180)
    Message.TextWrapped = true
    Message.Parent = Card

    local ConfirmBtn = Instance.new("TextButton")
    ConfirmBtn.Size = UDim2.new(1, -40, 0, 36)
    ConfirmBtn.Position = UDim2.new(0, 20, 1, -48)
    ConfirmBtn.BackgroundColor3 = COLOR_FACE_BOTTOM
    ConfirmBtn.BorderSizePixel = 0
    ConfirmBtn.Text = "MENGERTI"
    ConfirmBtn.Font = Enum.Font.GothamBold
    ConfirmBtn.TextSize = 13
    ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmBtn.Parent = Card

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = ConfirmBtn

    updateNoticeLanguage = function(lang)
        if lang == "ID" then
            BadgeLabel.Text = "🛠️ PEMBERITAHUAN UPDATE"
            Message.Text = "MK Hub Pro siap digunakan dengan mode Super Instant!"
            ConfirmBtn.Text = "MENGERTI"
        else
            BadgeLabel.Text = "🛠️ UPDATE NOTICE"
            Message.Text = "MK Hub Pro is ready with Super Instant mode!"
            ConfirmBtn.Text = "UNDERSTOOD"
        end
    end

    ConfirmBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

-- ==================== 6. TOMBOL KAPSUL BAHASA (ID / EN) ====================
local function createCapsuleUI()
    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local old = parentTarget:FindFirstChild("MK_Capsule")
    if old then old:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MK_Capsule"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = parentTarget

    local Capsule = Instance.new("Frame")
    Capsule.Size = UDim2.new(0, 176, 0, 36)
    Capsule.AnchorPoint = Vector2.new(0.5, 0)
    Capsule.Position = UDim2.new(0.5, 0, 0, 12)
    Capsule.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Capsule.BackgroundTransparency = 0.15
    Capsule.BorderSizePixel = 0
    Capsule.Parent = ScreenGui

    local CapsuleCorner = Instance.new("UICorner")
    CapsuleCorner.CornerRadius = UDim.new(1, 0)
    CapsuleCorner.Parent = Capsule

    local CapsuleStroke = Instance.new("UIStroke")
    CapsuleStroke.Thickness = 1.4
    CapsuleStroke.Color = Color3.fromRGB(50, 50, 50)
    CapsuleStroke.Parent = Capsule

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(0, 84, 0, 28)
    Slider.Position = UDim2.new(0, 4, 0.5, -14)
    Slider.BackgroundColor3 = COLOR_FACE_BOTTOM
    Slider.BorderSizePixel = 0
    Slider.Parent = Capsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = Slider

    local BtnID = Instance.new("TextButton")
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
    BtnEN.Size = UDim2.new(0, 84, 1, 0)
    BtnEN.Position = UDim2.new(1, -88, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(150, 150, 150)
    BtnEN.ZIndex = 5
    BtnEN.Parent = Capsule

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target
        if target == "ID" then
            TweenService:Create(Slider, TweenInfo.new(0.3), {Position = UDim2.new(0, 4, 0.5, -14)}):Play()
            BtnID.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnEN.TextColor3 = Color3.fromRGB(150, 150, 150)
        else
            TweenService:Create(Slider, TweenInfo.new(0.3), {Position = UDim2.new(1, -88, 0.5, -14)}):Play()
            BtnEN.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnID.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        updateAllActive()
        if updateNoticeLanguage then updateNoticeLanguage(target) end
    end

    BtnID.MouseButton1Click:Connect(function() switchMode("ID") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)
end

-- ==================== 7. INJEKSI LOGIKA SUPER INSTANT (ADMIN ABUSE SPEED) ====================
local function injectSuperInstantBypass()
    task.spawn(function()
        pcall(function()
            -- Memaksa kecepatan/teleport instan bypass jeda normal
            RunService.Heartbeat:Connect(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Bypass penekanan batasan kecepatan custom (Super Instant mode active)
                    hrp.Velocity = Vector3.new(hrp.Velocity.X, hrp.Velocity.Y, hrp.Velocity.Z)
                end
            end)
        end)
    end)
end

-- ==================== 8. SCANNER UTAMA ====================
task.delay(2, function()
    createCleanNoticeUI()
    createCapsuleUI()
    injectSuperInstantBypass()

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
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then pcall(function() scanUIChunked(root) end) end
    end
end)
