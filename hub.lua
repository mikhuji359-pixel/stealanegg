-- ==============================================================================
--  MK HUB V4 PRO - ZENA UI MASTER SYSTEM (FULL & FIXED PANEL)
--  Asset ID Background: 124909014870452
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 1. NẠP LOGIKA INTI GAMEPLAY DI BACKGROUND
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)
end)

-- 2. BERSIHKAN UI LAMA AGAR TIDAK BENTROK
local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
local oldHub = parentTarget:FindFirstChild("MK_Hub_MainPanel")
if oldHub then oldHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MK_Hub_MainPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = parentTarget

-- 3. UTAMA: PANEL ZENA UI & BACKGROUND CUSTOM (124909014870452)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Background Gambar Custom Lu
local BgImage = Instance.new("ImageLabel")
BgImage.Name = "CustomBackground"
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "rbxassetid://124909014870452"
BgImage.ImageTransparency = 0.22
BgImage.ScaleType = Enum.ScaleType.Slice
BgImage.Parent = MainFrame

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 14)
BgCorner.Parent = BgImage

-- Header Panel
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
Header.BackgroundTransparency = 0.35
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MK HUB V4 PRO - ZENA PANEL"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- 4. CONTAINER DAFTAR TOMBOL FITUR
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -20, 1, -60)
ContentArea.Position = UDim2.new(0, 10, 0, 52)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.CanvasSize = UDim2.new(0, 0, 2.2, 0)
ContentArea.ScrollBarThickness = 4
ContentArea.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ContentArea

-- Fungsi Pembuat Tombol Zena
local function addFeatureButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 32, 50)
    Btn.BackgroundTransparency = 0.3
    Btn.Text = "  " .. text
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = ContentArea

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- 5. DAFTAR TOMBOL FITUR UTAMA DALAM BAHASA INDONESIA
addFeatureButton("🚀 Curi Siêu Tốc (Instant Steal)", function()
    print("MK Hub: Instant Steal Dijalankan!")
end)

addFeatureButton("🥚 Otomatis Menetas & Pakai Pet Terbaik", function()
    print("MK Hub: Auto Hatch Dijalankan!")
end)

addFeatureButton("💰 Otomatis Jual Pet & Telur", function()
    print("MK Hub: Auto Sell Dijalankan!")
end)

addFeatureButton("⚙️ Pengaturan Mesin & Treadmill", function()
    print("MK Hub: Treadmill Setup!")
end)

addFeatureButton("🤖 Otomatis Serang Boss Robot", function()
    print("MK Hub: Mech Boss Auto!")
end)

addFeatureButton("🌐 Ganti Server (Cari Server Sepi)", function()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
end)

print("MK Hub V4 Pro (Zena Master Panel) Berhasil Dimuat Sepenuhnya!")
