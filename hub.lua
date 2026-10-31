--[[
    Steal An Egg / MK Hub [MAX ULTRA VERSION - CLEAN BG]
    Full Rebuild - Obsidian UI + Instant Steal (Payload Bypass) + Clean Minimalist BG
    Written cleanly for zero
]]

-- ============================================================
-- SERVICES & LIBRARY
-- ============================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local TweenService      = game:GetService("TweenService")
local TeleportService   = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local HttpService       = game:GetService("HttpService")
local UserInputService  = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

-- ============================================================
-- STATE (centralized, easy to clean)
-- ============================================================
local State = {
    Unloaded        = false,
    AutoSteal       = false,
    InstantSteal    = true,
    SnatchDrop      = true,
    AntiSnatch      = true,
    FarmMethod      = "Speed",
    AntiTrap        = true,
    AreaFocus       = {},
    RarityFilter    = {},
    SecretPriority  = true,
    AutoHop         = false,
    MaxHops         = 15,
    HopDelay        = 20,
    HopCount        = 0,
    AutoHatch       = false,
    HatchOnce       = false,
    EggESP          = false,
    PetESP          = false,
    FpsBoost        = false,
    AutoEquipBest   = false,
    AutoClaim       = false,
    ClaimInterval   = 20,
    AutoUpgrade     = false,
    UpgradeInterval = 30,
    AutoTreadmill   = false,
    AntiCheat       = false,
    HumReady        = false,
}

local Connections = {}
local Threads     = {}
local Caches      = {
    eggList      = {},
    eggListAt    = 0,
    triedUids    = {},
    failUids     = {},
    uidShape     = {},
    slotsCache   = nil,
    carryingUid  = nil,
    travelToken  = 0,
    travelling   = false,
    lastSnatchAt = 0,
}

local AreaData = {
    label       = {},
    rarity      = {},
    tierName    = {},
    byLabel     = {},
    order       = {},
    wanted      = {},
    wantedCount = 0,
}

local RarityWanted = {}
local RarityWantedCount = 0

local Rarities = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary",
    "Mythic", "Cosmic", "Secret", "Divine", "Eternal",
}
local RarityLadder = {}
for i, r in ipairs(Rarities) do
    RarityLadder[r] = i
end

-- ============================================================
-- CLEANUP / MEMORY MANAGEMENT
-- ============================================================
local function TrackConn(conn)
    if conn then table.insert(Connections, conn) end
    return conn
end

local function TrackThread(th)
    if th then table.insert(Threads, th) end
    return th
end

local function SafeSpawn(fn)
    return TrackThread(task.spawn(function()
        xpcall(fn, function(err)
            warn("[MK Hub] " .. tostring(err) .. "\n" .. debug.traceback())
        end)
    end))
end

local function Notify(title, content, time)
    if State.Unloaded then return end
    pcall(function()
        Library:Notify({
            Title = title or "MK Hub",
            Description = content or "",
            Time = time or 4,
        })
    end)
end

local function IsAlive()
    return not State.Unloaded
end

local function GetHRP()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildWhichIsA("Humanoid")
end

local function IsCharacterReady()
    local hrp = GetHRP()
    local hum = GetHumanoid()
    return hrp ~= nil and hum ~= nil and hum.Health > 0
end

local MAX_CACHE = 300
local function PruneTable(t)
    if type(t) ~= "table" then return end
    local n = 0
    for _ in pairs(t) do n += 1 end
    if n <= MAX_CACHE then return end
    local keys = {}
    for k in pairs(t) do keys[#keys + 1] = k end
    for i = 1, math.floor(#keys / 2) do
        t[keys[i]] = nil
    end
end

TrackThread(task.spawn(function()
    while IsAlive() do
        task.wait(40)
        if not IsAlive() then break end
        PruneTable(Caches.triedUids)
        PruneTable(Caches.failUids)
        PruneTable(Caches.uidShape)
    end
end))

local EggESPFolder, PetESPFolder, VisualPetsFolder, VisualPets

local function FullUnload()
    State.Unloaded = true
    State.AutoSteal = false
    State.AutoHop = false
    State.AutoHatch = false
    State.EggESP = false
    State.PetESP = false
    State.AutoEquipBest = false
    State.AutoClaim = false
    State.AutoUpgrade = false
    State.AutoTreadmill = false
    State.FpsBoost = false

    for i = #Connections, 1, -1 do
        local c = Connections[i]
        pcall(function() if c and c.Disconnect then c:Disconnect() end end)
        Connections[i] = nil
    end
    table.clear(Connections)

    for i = #Threads, 1, -1 do
        pcall(task.cancel, Threads[i])
        Threads[i] = nil
    end
    table.clear(Threads)

    Caches.eggList = {}
    Caches.triedUids = {}
    Caches.failUids = {}
    Caches.uidShape = {}

    if VisualPets and VisualPets.conn then
        pcall(function() VisualPets.conn:Disconnect() end)
    end
    if VisualPetsFolder and VisualPetsFolder.Parent then
        pcall(function() VisualPetsFolder:Destroy() end)
    end
    if EggESPFolder and EggESPFolder.Parent then
        pcall(function() EggESPFolder:Destroy() end)
    end
    if PetESPFolder and PetESPFolder.Parent then
        pcall(function() PetESPFolder:Destroy() end)
    end

    pcall(function() if collectgarbage then collectgarbage("collect") end end)
    Notify("Unloaded", "Script stopped, memory cleaned.", 3)
end

-- ============================================================
-- NETWORKING & INSTANT STEAL PAYLOAD BYPASS
-- ============================================================
local Packages = ReplicatedStorage:FindFirstChild("Packages")
local Networking = Packages and Packages:FindFirstChild("Networking")

local Remotes = {
    EggSnapshot   = "RF/EggWorld/AskFieldEggSnapshot",
    EggCarry      = "RF/EggWorld/AskFieldEggCarry",
    EggPlace      = "RF/EggWorld/AskPlaceEgg",
    EggDrop       = "RF/EggWorld/AskFieldEggDrop",
    Hatch         = "RF/EggWorld/AskHatch",
    PlotState     = "RF/Homestead/AskState",
    BaseTierRaise = "RE/Homestead/AskBaseTierRaise",
    Collect       = "RF/AwayEarnings/AskCollect",
    PendingCheck  = "RF/AwayEarnings/PendingCheck",
    WearBest      = "RF/Haul/WearBest",
    TreadRaise    = "RF/Treadmill/AskTierRaise",
}

local function GetRemote(name)
    if not Networking then return nil end
    return Networking:FindFirstChild(name)
end

local function Invoke(name, ...)
    local r = GetRemote(name)
    if not r then return nil end
    if r:IsA("RemoteFunction") then
        local ok, res = pcall(r.InvokeServer, r, ...)
        return ok and res or nil
    end
    pcall(r.FireServer, r, ...)
    return true
end

local function FireUid(remoteName, uid)
    local shape = Caches.uidShape[remoteName]
    if shape ~= 2 then
        local res = Invoke(remoteName, { Uid = uid })
        if res ~= nil and res ~= false then
            Caches.uidShape[remoteName] = 1
            return true
        end
        if shape == 1 then return false end
    end
    local res = Invoke(remoteName, uid)
    if res ~= nil and res ~= false then
        Caches.uidShape[remoteName] = 2
        return true
    end
    return false
end

-- Update metode payload bypass untuk menghindari cooldown server pasca update
local function FireInstantSteal(remoteName, uid)
    local r = GetRemote(remoteName)
    if not r then return false end
    
    local success, res = pcall(function()
        if r:IsA("RemoteFunction") then
            return r:InvokeServer({
                Uid = uid,
                Timestamp = tick(),
                Bypass = true,
                Source = "ClientSnapshot"
            })
        else
            r:FireServer({
                Uid = uid,
                Timestamp = tick(),
                Bypass = true,
                Source = "ClientSnapshot"
            })
            return true
        end
    end)
    
    if success and res ~= false then
        return true
    end
    return FireUid(remoteName, uid)
end

-- ============================================================
-- AREAS SETUP
-- ============================================================
local function RegisterArea(id, label, rarityNum, tierName)
    if not id or AreaData.label[id] then return end
    label = label or id
    AreaData.label[id] = label
    AreaData.rarity[id] = rarityNum or 0
    AreaData.tierName[id] = tierName
    AreaData.byLabel[label] = id
    table.insert(AreaData.order, id)
end

local function SortAreas()
    table.sort(AreaData.order, function(a, b)
        local ra = AreaData.rarity[a] or 0
        local rb = AreaData.rarity[b] or 0
        if ra == rb then
            return tostring(AreaData.label[a]) < tostring(AreaData.label[b])
        end
        return ra < rb
    end)
end

local function GetAreaLabels()
    local t = {}
    for _, id in ipairs(AreaData.order) do
        table.insert(t, AreaData.label[id])
    end
    return t
end

do
    local Data = ReplicatedStorage:FindFirstChild("Data")
    local AreasMod = Data and Data:FindFirstChild("Areas")
    local ok, result = pcall(function() return AreasMod and require(AreasMod) end)
    local dir = ok and type(result) == "table" and (result.Directory or result) or nil
    if type(dir) == "table" then
        for k, v in pairs(dir) do
            if type(k) == "string" and type(v) == "table" then
                local num, name = 0, nil
                if type(v.Rarity) == "table" then
                    num = tonumber(v.Rarity.RarityNumber) or 0
                    name = v.Rarity.DisplayName or v.Rarity._id
                end
                RegisterArea(k, v.DisplayName or v.Name or k, num, name)
            end
        end
    end
    if #AreaData.order == 0 then
        local folder = Workspace:FindFirstChild("Areas") or Workspace:FindFirstChild("Islands")
        if folder then
            local n = 0
            for _, child in ipairs(folder:GetChildren()) do
                n += 1
                RegisterArea(child.Name, child.Name, n, nil)
            end
        end
    end
    SortAreas()
end

local function RebuildAreaWanted()
    local map = {}
    local count = 0
    for _, label in ipairs(State.AreaFocus) do
        local id = AreaData.byLabel[label] or label
        map[id] = true
        count += 1
    end
    AreaData.wanted = map
    AreaData.wantedCount = count
end

local function RebuildRarityWanted()
    local map = {}
    local count = 0
    for _, r in ipairs(State.RarityFilter) do
        map[r] = true
        count += 1
    end
    RarityWanted = map
    RarityWantedCount = count
end

local function RarityRank(name)
    return RarityLadder[name] or 0
end

-- ============================================================
-- ADVANCED SCAN & STEAL CORE
-- ============================================================
local function GetEggSlotsRoot()
    if Caches.slotsCache and Caches.slotsCache.Parent then
        return Caches.slotsCache
    end
    Caches.slotsCache = Workspace:FindFirstChild("AreaEggSlotsClient")
    return Caches.slotsCache
end

local function GetSlotHitbox(areaId)
    local root = GetEggSlotsRoot()
    local m = root and root:FindFirstChild(areaId)
    if not m then return nil end
    return m.PrimaryPart or m:FindFirstChild("Hitbox") or m:FindFirstChildWhichIsA("BasePart")
end

local function HasMutation(egg)
    if egg.BaseMutation then return true end
    return type(egg.Mutations) == "table" and next(egg.Mutations) ~= nil
end

local function RefreshEggList(force)
    if not force and tick() - Caches.eggListAt < 1.0 then
        return Caches.eggList
    end

    local list = {}
    local snap = Invoke(Remotes.EggSnapshot)
    if type(snap) ~= "table" then
        Caches.eggList = list
        Caches.eggListAt = tick()
        return list
    end

    local entries = snap.Eggs or snap.List or snap
    for _, egg in pairs(entries) do
        if type(egg) == "table" and (egg.Uid or egg.uid or egg.ID) then
            local uid = egg.Uid or egg.uid or egg.ID
            local rarity = egg.Rarity or egg.rarity or egg.RarityName or "Common"
            if type(rarity) == "table" then rarity = rarity.DisplayName or rarity._id or "Common" end
            local area = egg.Area or egg.area or egg.Field or egg.Zone or ""
            table.insert(list, {
                uid = tostring(uid),
                rarity = tostring(rarity),
                area = tostring(area),
                rank = RarityRank(tostring(rarity)),
                mutation = HasMutation(egg),
                raw = egg,
            })
        end
    end

    table.sort(list, function(a, b)
        if State.SecretPriority then
            local aSec = (a.rank >= 8) and 1 or 0
            local bSec = (b.rank >= 8) and 1 or 0
            if aSec ~= bSec then return aSec > bSec end
        end
        if a.rank ~= b.rank then return a.rank > b.rank end
        return a.uid < b.uid
    end)

    Caches.eggList = list
    Caches.eggListAt = tick()
    return list
end

local function PassesFilter(egg)
    if RarityWantedCount > 0 and not RarityWanted[egg.rarity] then return false end
    if AreaData.wantedCount > 0 then
        local areaId = AreaData.byLabel[egg.area] or egg.area
        if not AreaData.wanted[areaId] and not AreaData.wanted[egg.area] then return false end
    end
    if (Caches.failUids[egg.uid] or 0) >= 4 then return false end
    local lastTry = Caches.triedUids[egg.uid]
    if lastTry and tick() - lastTry < 1.5 then return false end
    return true
end

local function CheckAndSnatchDroppedEggs()
    if not State.SnatchDrop then return end
    if tick() - Caches.lastSnatchAt < 0.25 then return end
    
    local eggs = RefreshEggList(true)
    for _, egg in ipairs(eggs) do
        if egg.raw and (egg.raw.Dropped or egg.raw.IsDropped or egg.raw.Carrier == nil) then
            Caches.lastSnatchAt = tick()
            FireInstantSteal(Remotes.EggCarry, egg.uid)
            Notify("Snatch Drop!", "Berhasil nyamber telur drop-an rival!", 1.5)
            break
        end
    end
end

local function AntiSnatchProtectionLoop()
    while IsAlive() do
        task.wait(0.2)
        if State.AntiSnatch and Caches.carryingUid then
            local hrp = GetHRP()
            if hrp then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local enemyHrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if enemyHrp and (enemyHrp.Position - hrp.Position).Magnitude < 14 then
                            Invoke(Remotes.EggDrop)
                            Caches.carryingUid = nil
                            Notify("Anti-Snatch", "Musuh mendekat! Telur langsung diamankan.", 2)
                            break
                        end
                    end
                end
            end
        end
    end
end
SafeSpawn(AntiSnatchProtectionLoop)

-- ============================================================
-- AUTO STEAL LOOP (MK GACOR MODE)
-- ============================================================
local function AutoStealLoop()
    while IsAlive() and State.AutoSteal do
        if not IsCharacterReady() then
            task.wait(0.5)
            continue
        end

        CheckAndSnatchDroppedEggs()

        local eggs = RefreshEggList()
        local target = nil

        for _, egg in ipairs(eggs) do
            if PassesFilter(egg) then
                target = egg
                break
            end
        end

        if target then
            Caches.triedUids[target.uid] = tick()
            local ok = FireInstantSteal(Remotes.EggCarry, target.uid)
            if ok then
                Caches.carryingUid = target.uid
                Caches.failUids[target.uid] = nil
                task.wait(State.InstantSteal and 0.05 or 0.3)
            else
                Caches.failUids[target.uid] = (Caches.failUids[target.uid] or 0) + 1
                task.wait(0.2)
            end
        else
            task.wait(0.3)
        end

        if State.AntiTrap then
            local hum = GetHumanoid()
            if hum and hum.Health > 0 and hum.WalkSpeed < 8 then
                pcall(function() hum.WalkSpeed = 16 end)
            end
        end
    end
end

-- ============================================================
-- AUTOMATION LOOPS
-- ============================================================
local function ServerHop()
    if not IsAlive() then return end
    State.HopCount += 1
    Notify("Server Hop", "Pindah server... (" .. State.HopCount .. "/" .. State.MaxHops .. ")", 3)
    pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
end

local function AutoHopLoop()
    while IsAlive() and State.AutoHop do
        task.wait(State.HopDelay)
        if not IsAlive() or not State.AutoHop then break end
        if State.HopCount >= State.MaxHops then
            State.AutoHop = false
            break
        end
        ServerHop()
    end
end

local function AutoHatchLoop()
    while IsAlive() and State.AutoHatch do
        local eggs = RefreshEggList(true)
        for _, egg in ipairs(eggs) do
            if not IsAlive() or not State.AutoHatch then break end
            if PassesFilter(egg) or RarityWantedCount == 0 then
                Invoke(Remotes.Hatch, egg.uid)
                task.wait(0.25)
                if State.HatchOnce then
                    State.AutoHatch = false
                    break
                end
            end
        end
        task.wait(1.0)
    end
end

local function AutoClaimLoop()
    while IsAlive() and State.AutoClaim do
        Invoke(Remotes.Collect)
        Invoke(Remotes.PendingCheck)
        task.wait(State.ClaimInterval)
    end
end

local function AutoEquipLoop()
    while IsAlive() and State.AutoEquipBest do
        Invoke(Remotes.WearBest)
        task.wait(8)
    end
end

local function AutoUpgradeLoop()
    while IsAlive() and State.AutoUpgrade do
        Invoke(Remotes.BaseTierRaise)
        task.wait(State.UpgradeInterval)
    end
end

local function AutoTreadmillLoop()
    while IsAlive() and State.AutoTreadmill do
        Invoke(Remotes.TreadRaise)
        task.wait(5)
    end
end

-- ============================================================
-- ESP SYSTEM
-- ============================================================
EggESPFolder = Instance.new("Folder")
EggESPFolder.Name = "MKEggESP"
EggESPFolder.Parent = Workspace

local function ClearFolder(folder)
    if not folder then return end
    for _, c in ipairs(folder:GetChildren()) do pcall(function() c:Destroy() end) end
end

local function MakeBillboard(adornee, text, color)
    local bb = Instance.new("BillboardGui")
    bb.Adornee = adornee
    bb.Size = UDim2.fromOffset(130, 45)
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 3, 0)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.fromScale(1, 1)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 220, 80)
    lbl.TextStrokeTransparency = 0.4
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.Parent = bb
    return bb
end

local function EggESPLoop()
    while IsAlive() and State.EggESP do
        ClearFolder(EggESPFolder)
        local eggs = RefreshEggList()
        local root = GetEggSlotsRoot()
        if root then
            for _, egg in ipairs(eggs) do
                if not IsAlive() then break end
                local slot = GetSlotHitbox(egg.area)
                if slot then
                    local bb = MakeBillboard(slot, egg.rarity .. "\n" .. egg.uid:sub(1, 6), Color3.fromRGB(255, 200, 60))
                    bb.Parent = EggESPFolder
                end
            end
        end
        task.wait(1.5)
    end
    ClearFolder(EggESPFolder)
end

-- ============================================================
-- VISUAL PETS (Client Side)
-- ============================================================
VisualPetsFolder = Instance.new("Folder")
VisualPetsFolder.Name = "MKVisualPets"
VisualPetsFolder.Parent = Workspace

VisualPets = {
    spawned = {},
    orbitRadius = 4,
    orbitSpeed = 0.8,
    conn = nil,
    petNames = {},
    inputName = "",
}

local function ScanPetNames()
    local seen, names = {}, {}
    for _, child in ipairs(Workspace:GetChildren()) do
        for _, m in ipairs(child:GetChildren()) do
            if m:IsA("Model") and not m.Name:lower():find("humanoid") and m:FindFirstChildWhichIsA("BasePart") and not seen[m.Name] then
                seen[m.Name] = true
                table.insert(names, m.Name)
            end
        end
    end
    table.sort(names)
    VisualPets.petNames = names
    return names
end

local function SpawnVisualPet(name)
    local src = nil
    for _, d in ipairs(Workspace:GetDescendants()) do
        if d:IsA("Model") and d.Name:lower():find(name:lower(), 1, true) and d:FindFirstChildWhichIsA("BasePart") and not d:IsDescendantOf(VisualPetsFolder) then
            src = d
            break
        end
    end
    if not src then
        Notify("Visual Pets", "Model tidak ditemukan: " .. name, 3)
        return
    end
    local clone = src:Clone()
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA("Script") or d:IsA("LocalScript") then d:Destroy()
        elseif d:IsA("BasePart") then
            d.Anchored = true
            d.CanCollide = false
            d.CastShadow = false
        end
    end
    clone.Name = "VP_" .. name
    clone.Parent = VisualPetsFolder
    table.insert(VisualPets.spawned, { model = clone })
    Notify("Visual Pets", "Berhasil spawn " .. name, 2)
end

VisualPets.conn = TrackConn(RunService.Heartbeat:Connect(function()
    if not IsAlive() or #VisualPets.spawned == 0 then return end
    local hrp = GetHRP()
    if not hrp then return end
    local t = tick()
    local center = hrp.Position + Vector3.new(0, 1, 0)
    local n = #VisualPets.spawned
    for i, v in ipairs(VisualPets.spawned) do
        local ang = (i - 1) * (math.pi * 2 / n) + t * VisualPets.orbitSpeed
        local offset = Vector3.new(math.cos(ang) * VisualPets.orbitRadius, 0, math.sin(ang) * VisualPets.orbitRadius)
        pcall(function() v.model:PivotTo(CFrame.new(center + offset)) end)
    end
end))

-- ============================================================
-- UI SETUP (MK HUB CLEAN MINIMALIST)
-- ============================================================
local Window = Library:CreateWindow({
    Title = "MK Hub | MAX ULTRA EDITION",
    Footer = "Clean Minimalist • Payload Instant Steal & Snatch",
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    ToggleKeybind = Enum.KeyCode.RightControl,
})

local Tabs = {
    Main   = Window:AddTab("Main", "egg"),
    Steal  = Window:AddTab("Steal", "target"),
    Farm   = Window:AddTab("Farm", "zap"),
    Visual = Window:AddTab("Visual", "eye"),
    Config = Window:AddTab("Config", "settings"),
}

-- MAIN TAB
local MainLeft  = Tabs.Main:AddLeftGroupbox("Status")
local MainRight = Tabs.Main:AddRightGroupbox("Quick Actions")

MainLeft:AddLabel("Areas Loaded: " .. #AreaData.order, true)
MainLeft:AddLabel("Networking: " .. (Networking and "OK" or "MISSING"), true)
MainLeft:AddLabel("Press RightCtrl to toggle UI", true)

MainRight:AddButton({
    Text = "Refresh Egg Snapshot",
    Func = function()
        local list = RefreshEggList(true)
        Notify("Eggs", #list .. " eggs found", 3)
    end,
})

MainRight:AddButton({
    Text = "Rejoin Server",
    Func = function()
        pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end)
    end,
})

-- STEAL TAB
local StealLeft  = Tabs.Steal:AddLeftGroupbox("Auto Steal & Gacor Modes")
local StealRight = Tabs.Steal:AddRightGroupbox("Filters")

StealLeft:AddToggle("AutoSteal", {
    Text = "Auto Steal",
    Default = false,
    Callback = function(v)
        State.AutoSteal = v
        if v then
            SafeSpawn(AutoStealLoop)
            Notify("Auto Steal", "Enabled (Gacor)", 2)
        end
    end,
})

StealLeft:AddToggle("InstantSteal", {
    Text = "Instant Steal (Payload Bypass)",
    Default = true,
    Callback = function(v) State.InstantSteal = v end,
})

StealLeft:AddToggle("SnatchDrop", {
    Text = "Snatch Rival Drop (Nyolong Drop-an)",
    Default = true,
    Callback = function(v) State.SnatchDrop = v end,
})

StealLeft:AddToggle("AntiSnatch", {
    Text = "Anti-Snatch Protection (Anti Maling)",
    Default = true,
    Callback = function(v) State.AntiSnatch = v end,
})

StealLeft:AddDropdown("FarmMethod", {
    Text = "Farm Method",
    Values = { "Speed", "Safe" },
    Default = 1,
    Callback = function(v) State.FarmMethod = v or "Speed" end,
})

StealLeft:AddToggle("AntiTrap", {
    Text = "Anti Trap",
    Default = true,
    Callback = function(v) State.AntiTrap = v end,
})

StealLeft:AddToggle("SecretPriority", {
    Text = "Secret / Divine Priority",
    Default = true,
    Callback = function(v) State.SecretPriority = v end,
})

StealRight:AddDropdown("RarityFilter", {
    Text = "Rarity Filter",
    Values = Rarities,
    Multi = true,
    Default = {},
    Callback = function(v)
        local list = {}
        if type(v) == "table" then
            for k, on in pairs(v) do
                if on == true then table.insert(list, k)
                elseif type(on) == "string" then table.insert(list, on) end
            end
        end
        State.RarityFilter = list
        RebuildRarityWanted()
    end,
})

StealRight:AddDropdown("AreaFocus", {
    Text = "Area Focus",
    Values = GetAreaLabels(),
    Multi = true,
    Default = {},
    Callback = function(v)
        local list = {}
        if type(v) == "table" then
            for k, on in pairs(v) do
                if on == true then table.insert(list, k)
                elseif type(on) == "string" then table.insert(list, on) end
            end
        end
        State.AreaFocus = list
        RebuildAreaWanted()
    end,
})

StealRight:AddButton({
    Text = "Clear Tried / Fail Cache",
    Func = function()
        Caches.triedUids = {}
        Caches.failUids = {}
        Notify("Cache", "Cleared UIDs cache", 2)
    end,
})

-- FARM TAB
local FarmLeft  = Tabs.Farm:AddLeftGroupbox("Automation")
local FarmRight = Tabs.Farm:AddRightGroupbox("Server Hop")

FarmLeft:AddToggle("AutoHatch", {
    Text = "Auto Hatch",
    Default = false,
    Callback = function(v)
        State.AutoHatch = v
        if v then SafeSpawn(AutoHatchLoop) end
    end,
})

FarmLeft:AddToggle("HatchOnce", {
    Text = "Hatch Once Only",
    Default = false,
    Callback = function(v) State.HatchOnce = v end,
})

FarmLeft:AddToggle("AutoClaim", {
    Text = "Auto Claim Earnings",
    Default = false,
    Callback = function(v)
        State.AutoClaim = v
        if v then SafeSpawn(AutoClaimLoop) end
    end,
})

FarmLeft:AddToggle("AutoEquipBest", {
    Text = "Auto Equip Best",
    Default = false,
    Callback = function(v)
        State.AutoEquipBest = v
        if v then SafeSpawn(AutoEquipLoop) end
    end,
})

FarmLeft:AddToggle("AutoUpgrade", {
    Text = "Auto Upgrade Base",
    Default = false,
    Callback = function(v)
        State.AutoUpgrade = v
        if v then SafeSpawn(AutoUpgradeLoop) end
    end,
})

FarmLeft:AddToggle("AutoTreadmill", {
    Text = "Auto Treadmill",
    Default = false,
    Callback = function(v)
        State.AutoTreadmill = v
        if v then SafeSpawn(AutoTreadmillLoop) end
    end,
})

FarmRight:AddToggle("AutoHop", {
    Text = "Auto Server Hop",
    Default = false,
    Callback = function(v)
        State.AutoHop = v
        if v then SafeSpawn(AutoHopLoop) end
    end,
})

FarmRight:AddSlider("MaxHops", {
    Text = "Max Hops",
    Default = 15, Min = 1, Max = 50, Rounding = 0,
    Callback = function(v) State.MaxHops = v end,
})

FarmRight:AddSlider("HopDelay", {
    Text = "Hop Delay (s)",
    Default = 20, Min = 5, Max = 120, Rounding = 0,
    Callback = function(v) State.HopDelay = v end,
})

FarmRight:AddButton({
    Text = "Hop Now",
    Func = function() ServerHop() end,
})

-- VISUAL TAB
local VisLeft  = Tabs.Visual:AddLeftGroupbox("ESP")
local VisRight = Tabs.Visual:AddRightGroupbox("Visual Pets")

VisLeft:AddToggle("EggESP", {
    Text = "Egg ESP",
    Default = false,
    Callback = function(v)
        State.EggESP = v
        if v then SafeSpawn(EggESPLoop)
        else ClearFolder(EggESPFolder) end
    end,
})

VisLeft:AddToggle("FpsBoost", {
    Text = "FPS Boost",
    Default = false,
    Callback = function(v)
        pcall(function() settings().Rendering.QualityLevel = v and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic end)
    end,
})

local petDropdown = VisRight:AddDropdown("PetList", {
    Text = "Pet Model",
    Values = { "Click Refresh" },
    Default = 1,
    Callback = function(v) if type(v) == "string" then VisualPets.inputName = v end end,
})

VisRight:AddButton({
    Text = "Refresh Pet List",
    Func = function()
        local names = ScanPetNames()
        pcall(function() petDropdown:SetValues(names) end)
        Notify("Pets", #names .. " models found", 2)
    end,
})

VisRight:AddInput("CustomPet", {
    Text = "Custom Name", Default = "", Placeholder = "e.g. Dragon",
    Callback = function(v) VisualPets.inputName = v end,
})

VisRight:AddButton({
    Text = "Spawn Pet",
    Func = function()
        if VisualPets.inputName == "" then Notify("Visual Pets", "Ketik nama pet dulu", 3) return end
        SpawnVisualPet(VisualPets.inputName)
    end,
})

VisRight:AddButton({
    Text = "Clear Visual Pets",
    Func = function()
        for _, v in ipairs(VisualPets.spawned) do pcall(function() v.model:Destroy() end) end
        VisualPets.spawned = {}
        Notify("Visual Pets", "Cleared", 2)
    end,
})

-- CONFIG TAB
local CfgLeft  = Tabs.Config:AddLeftGroupbox("Info")
local CfgRight = Tabs.Config:AddRightGroupbox("Danger Zone")

CfgLeft:AddLabel("MK Hub MAX\nInstant Steal + Snatch + Anti-Snatch", true)

CfgRight:AddButton({
    Text = "Unload Script (Full Clean)",
    Func = function()
        FullUnload()
        pcall(function() Library:Unload() end)
    end,
})

-- ============================================================
-- BOOT
-- ============================================================
if not Networking then
    Notify("Warning", "Packages.Networking missing!", 8)
else
    Notify("MK Hub", "Loaded successfully. Gacor mode ready!", 5)
end

print("[MK Hub] MAX Ultra Version Loaded.")
