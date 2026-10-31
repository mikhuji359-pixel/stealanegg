-- ==============================================================================
--  MK HUB V4 PRO - ZENA EDITION (BACKGROUND ASSET & FULL LOGIC)
--  Asset Image ID: 124909014870452
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

-- ==================== 2. TỪ ĐIỂN DỊCH THUẬT MASTER (MK HUB BRANDING) ====================
local currentLanguage = "VI"
local FastCache = {}
local updateNoticeLanguage = nil -- Hàm cập nhật ngôn ngữ cho Bảng Thông Báo

local function replaceAll(str, findStr, replaceStr)
    local startIdx, endIdx = str:find(findStr, 1, true)
    while startIdx do
        str = str:sub(1, startIdx - 1) .. replaceStr .. str:sub(endIdx + 1)
        startIdx, endIdx = str:find(findStr, startIdx + #replaceStr, true)
    end
    return str
end

local EXACT_MATCH_VI = {
    ["Chilli Hub"] = "MK Hub V8",
    ["Hop"] = "Đổi Server",
    ["Join"] = "Vào Phòng",
    ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại",
    ["Add"] = "Thêm",
    ["Sell"] = "Bán",
    ["Favorite"] = "Khóa",
    ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI",
    ["All"] = "Tất cả",
    ["ALL"] = "TẤT CẢ",
    ["Any"] = "Tất cả",
    ["None"] = "Không có",
    ["Off"] = "Tắt",
    ["OFF"] = "TẮT",
    ["On"] = "Bật",
    ["ON"] = "BẬT",
    ["Idle"] = "Đang rảnh",
    ["IDLE"] = "ĐANG RẢNH",
    ["Stand"] = "Đứng yên",
    ["Chase"] = "Đuổi theo",
    ["Circle"] = "Xoay vòng",
    ["Patrol"] = "Tuần tra",
    ["Rarest"] = "Hiếm nhất",
    ["Nearest"] = "Gần nhất",
    ["Always"] = "Luôn luôn",
    ["Never"] = "Không bao giờ",
    ["Value"] = "Giá trị",
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)",
    ["Rare"] = "Hiếm (Rare)",
    ["Uncommon"] = "Thường (Uncommon)",
    ["Common"] = "Phổ Thông (Common)",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["Least Players"] = "Ít người chơi nhất",
    ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm",
    ["Rarity And Value"] = "Độ hiếm & Giá trị",
    ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước",
    ["Lowest To Highest"] = "Từ thấp đến cao",
    ["Highest To Lowest"] = "Từ cao đến thấp",
    ["Match All"] = "Khớp tất cả",
    ["Match Any"] = "Khớp bất kỳ",
    ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất",
    ["3 - Rare"] = "3 - Hiếm (Rare)",
    ["6 - Mythic"] = "6 - Thần Thoại (Mythic)",
    ["EGGS"] = "TRỨNG",
    ["READY"] = "SẴN SÀNG",
    ["GROWING"] = "ĐANG LỚN",
    ["IN BAG"] = "TRONG TÚI",
    ["TOTAL / S"] = "TỔNG / GIÂY",
    ["SCRAMBLED"] = "ĐÃ BIẾN ĐỔI",
    ["GOLDEN"] = "VÀNG",
    ["SILVER"] = "BẠC",
    ["RAINBOW"] = "CẦU VỒNG",

    -- ==================== PANEL REBRANDING ====================
    ["Venyx"] = "MK Panel",
    ["Try now"] = "Thử ngay",
    ["Smoother, faster and more ways to steal."] = "Mượt hơn, nhanh hơn và nhiều cách cướp hơn.",
    ["✓ Smoother & faster"] = "✓ Mượt & nhanh hơn",
    ["Smoother & faster"] = "Mượt & nhanh hơn",
    ["Less lag, quick to load."] = "Giảm lag, tải nhanh.",
    ["✓ More steal methods"] = "✓ Nhiều kiểu cướp hơn",
    ["More steal methods"] = "Nhiều kiểu cướp hơn",
    ["Teleport, Fast tween and..."] = "Dịch chuyển, Tween nhanh và hơn thế nữa.",
    ["✓ Steal from players"] = "✓ Cướp từ người chơi",
    ["Steal from players"] = "Cướp từ người chơi",
    ["Hits whoever takes your egg"] = "Tấn công bất kỳ ai lấy trứng của bạn.",
    ["Hits whoever takes your eggBring your Chilli config"] = "Tấn công bất kỳ ai lấy trứng của bạn. Đồng bộ cấu hình MK của bạn.",
    ["✓ Easy setup"] = "✓ Cài đặt dễ dàng",
    ["Easy setup"] = "Cài đặt dễ dàng",
    ["Bring your Chilli config"] = "Đồng bộ cấu hình MK của bạn.",
    ["Bring your Chilli config..."] = "Đồng bộ cấu hình MK của bạn.",
    ["Filter features..."] = "Lọc tính năng...",

    -- ==================== SỰ KIỆN HALLOWEEN ====================
    ["HALLOWEEN"] = "HALLOWEEN",
    ["Halloween"] = "Halloween",
    ["HALLOWEEN DIMENSION"] = "CHIỀU KHÔNG GIAN HALLOWEEN",
    ["Halloween Dimension"] = "Chiều Không Gian Halloween",
    ["Auto steal Halloween eggs"] = "Tự động cướp trứng Halloween",
    ["Instant steal Halloween eggs"] = "Cướp tức thì trứng Halloween",
    ["Steal speed"] = "Tốc độ cướp",
    ["Halloween eggs"] = "Trứng Halloween",
    ["Halloween rarities"] = "Độ hiếm Halloween",
    ["Auto Pumpkin Moon"] = "Tự động Pumpkin Moon",
    ["Pumpkin Moon"] = "Pumpkin Moon",
    ["MONSTERS"] = "QUÁI VẬT",
    ["Monsters"] = "Quái vật",
    ["Auto farm monsters"] = "Tự động farm quái",
    ["Monster order"] = "Thứ tự quái",
    ["Khoảng cách gần nhất"] = "Khoảng cách gần nhất",
    ["Sử dụng vũ khí"] = "Sử dụng vũ khí",
    ["Use weapons"] = "Sử dụng vũ khí",
    ["Racing Bat"] = "Racing Bat",
    ["PHANTOM EXPRESS"] = "PHANTOM EXPRESS",
    ["Phantom Express"] = "Phantom Express",
    ["TRAIN"] = "TÀU",
    ["Train"] = "Tàu",
    ["SOULS"] = "LINH HỒN",
    ["Souls"] = "Linh hồn",
    ["Not here"] = "Không ở đây",
    ["Đang rảnh"] = "Đang rảnh",
    ["Idle"] = "Đang rảnh",
    ["IDLE"] = "ĐANG RẢNH",
    ["Walk speed"] = "Tốc độ đi",
    ["Sự Kiện"] = "Sự Kiện",
    ["Event"] = "Sự Kiện",
    ["Sao Băng"] = "Sao Băng",
    ["Bắt Bướm"] = "Bắt Bướm",
    ["Admin (AA)"] = "Admin (AA)"
}

local MAP_VI = {
    ["Chilli Hub"] = "MK Hub V8",
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Khác",
    ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt & Key",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...",
    ["Search"] = "Tìm kiếm",

    -- ==================== PANEL REBRANDING ====================
    ["Venyx"] = "MK Panel",
    ["Try now"] = "Thử ngay",
    ["Smoother, faster and more ways to steal."] = "Mượt hơn, nhanh hơn và nhiều cách cướp hơn.",
    ["✓ Smoother & faster"] = "✓ Mượt & nhanh hơn",
    ["Smoother & faster"] = "Mượt & nhanh hơn",
    ["Less lag, quick to load."] = "Giảm lag, tải nhanh.",
    ["✓ More steal methods"] = "✓ Nhiều kiểu cướp hơn",
    ["More steal methods"] = "Nhiều kiểu cướp hơn",
    ["Teleport, Fast tween and..."] = "Dịch chuyển, Tween nhanh và hơn thế nữa.",
    ["✓ Steal from players"] = "✓ Cướp từ người chơi",
    ["Steal from players"] = "Cướp từ người chơi",
    ["Hits whoever takes your egg"] = "Tấn công bất kỳ ai lấy trứng của bạn.",
    ["✓ Easy setup"] = "✓ Cài đặt dễ dàng",
    ["Easy setup"] = "Cài đặt dễ dàng",
    ["Bring your Chilli config"] = "Đồng bộ cấu hình MK của bạn.",
    ["Bring your Chilli config..."] = "Đồng bộ cấu hình MK của bạn.",

    ["Racing Event"] = "Sự Kiện Đua Xe",
    ["Auto Race"] = "Tự Động Đua Xe",
    ["Auto Claim Race Rewards"] = "Tự Nhận Thưởng Đua Xe",
    ["Auto Equip Racer"] = "Tự Trang Bị Tay Đua",
    ["Racer"] = "Tay Đua",
    ["Auto Buy Race Shop"] = "Tự Động Mua Shop Đua Xe",
    ["Race Shop Items"] = "Vật Phẩm Shop Đua Xe",
    ["Admin Abuse"] = "Lạm Dụng Admin",
    ["Shooting Star"] = "Sao Băng",
    ["Auto Catch Shooting Star"] = "Tự Động Bắt Sao Băng",
    ["Instant Steal V2"] = "Cướp Siêu Tốc V2",

    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble",
    ["Dr Scramble Lab"] = "Phòng Lab Dr. Scramble",
    ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp",
    ["Auto Steal"] = "Tự Động Cướp Trứng",
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Auto Treadmill"] = "Tự Động Máy Tập",
    ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị",
    ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Pet",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet",
    ["Auto Favorite"] = "Tự Động Khóa Pet",
    ["Priority"] = "Ưu Tiên Nhiệm Vụ",
    ["ESP"] = "Định Vị (ESP)",
    ["Movement"] = "Di Chuyển",
    ["Character"] = "Nhân Vật",
    ["Combat"] = "Chiến Đấu",
    ["Discord Webhook"] = "Cài Đặt Webhook Discord",
    ["Egg Predictor"] = "Dự Đoán Trứng",
    ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp",
    ["Auto Progression"] = "Tự Động Tiến Trình",
    ["Performance"] = "Hiệu Năng",
    ["Utility"] = "Tiện Ích",
    ["Egg Finder"] = "Dò Tìm Trứng",
    ["Quick Bar 1"] = "Thanh Phím Nhanh 1",
    ["Quick Bar 2"] = "Thanh Phím Nhanh 2",

    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm",
    ["Catch Mode"] = "Chế Độ Bắt",
    ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Only for Chase mode"] = "Chỉ dùng cho chế độ Đuổi theo",
    ["Catch Butterflies"] = "Chọn Bướm Cần Bắt",
    ["Radiant Butterfly"] = "Bướm Rực Rỡ",
    ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím",
    ["Sapphire Butterfly"] = "Bướm Lam Ngọc (Sapphire)",
    ["Emerald Butterfly"] = "Bướm Lục Bảo (Emerald)",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Auto Trade Up"] = "Tự Nâng Cấp Bướm",
    ["Trade Up Tiers"] = "Bậc Nâng Cấp",
    ["Smart Trade For Essence"] = "Đổi Bướm Lấy Tinh Chất Thông Minh",
    ["Going to the middle of the bloom"] = "Đang đi tới trung tâm khu bướm nở",

    ["Auto Craft Essence"] = "Tự Chế Tạo Tinh Chất",
    ["Auto Use Enchanted Essence"] = "Tự Dùng Tinh Chất Phù Phép",
    ["Essence Min Rarity"] = "Độ Hiếm Nhận Tinh Chất Min",
    ["Only eggs of this rarity and above get the essence"] = "Chỉ trứng đạt độ hiếm này trở lên mới nhận tinh chất",
    ["Essence Min Value"] = "Giá Trị Nhận Tinh Chất Min",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị nhỏ hơn mức này (0 = tắt)",
    ["Essence Target Eggs"] = "Mục Tiêu Trứng Nhận Tinh Chất",
    ["Only use the essence on these eggs (empty = all)"] = "Chỉ dùng tinh chất lên trứng này (trống = tất cả)",
    ["Essence Priority"] = "Ưu Tiên Dùng Tinh Chất",
    ["Which egg gets the essence first"] = "Trứng nào được ưu tiên nhận tinh chất trước",
    ["Essence Skip Enchanted Eggs"] = "Bỏ Qua Trứng Đã Phù Phép",
    ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "Bỏ qua trứng đã phù phép, đột biến khác vẫn nhận tinh chất",

    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc",
    ["Higher is safer but takes longer"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",
    ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Min Steal Value"] = "Giá Trị Cướp Min",
    ["Target Specific Eggs"] = "Chọn Đích Danh Trứng Cần Cướp",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu",
    ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp cả trứng còn thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Carry Speed"] = "Tốc Độ Bê Trứng",
    ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ",

    ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng",
    ["Only place eggs of the picked rarities (empty = all)"] = "Chỉ đặt trứng thuộc các độ hiếm đã chọn (trống = tất cả)",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Cần Đặt",
    ["Only place these eggs (empty = all)"] = "Chỉ đặt các trứng này (trống = tất cả)",
    ["Min Place Value"] = "Giá Trị Đặt Min",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị thấp hơn mức này (0 = tắt)",
    ["Stay On Treadmill"] = "Cố Định Trên Máy Tập",

    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "Ấp trứng từ độ hiếm đã chọn trở lên",
    ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Cần Ấp",
    ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Equip Best when a better pet appears"] = "Tự trang bị khi có pet mạnh hơn xuất hiện",

    ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell matching pets once"] = "Bán các pet khớp điều kiện một lần",
    ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Which checks must pass to sell"] = "Các điều kiện bắt buộc để bán",
    ["Pet Max Rarity"] = "Độ Hiếm Pet Max Cần Bán",
    ["Sell pets at or below this rarity"] = "Bán pet từ độ hiếm này trở xuống",
    ["Pet Sell Value"] = "Giá Trị Bán Pet Min",
    ["Sell pets worth less than this (0 = off)"] = "Bán pet có giá trị nhỏ hơn mức này (0 = tắt)",
    ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Never sell mutated pets"] = "Không bao giờ bán pet có đột biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["These pets are never sold"] = "Những pet này sẽ không bao giờ bị bán",
    ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi khớp quy tắc dưới",
    ["Sell Eggs Now"] = "Bán Trứng Ngay",
    ["Sell matching eggs once"] = "Bán một lần các trứng khớp điều kiện",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Trứng Max Cần Bán",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng Min",
    ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến",
    ["Never sell mutated eggs"] = "Không bao giờ bán trứng có đột biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng",
    ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "Bán trứng đổi từ Dr Scramble khớp bộ lọc dưới",
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay",
    ["Sell matching Lab eggs once"] = "Bán một lần các trứng Lab khớp điều kiện",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab",
    ["Lab Egg Max Rarity"] = "Độ Hiếm Trứng Lab Max Cần Bán",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "Bán trứng Lab từ độ hiếm này trở xuống (Off = tắt)",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab Min",
    ["Sell Lab eggs worth less than this (0 = off)"] = "Bán trứng Lab giá trị thấp hơn mức này (0 = tắt)",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến",
    ["Never sell mutated Lab eggs"] = "Không bao giờ bán trứng Lab có đột biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab",
    ["Lab eggs of these pets are never sold"] = "Trứng Lab của những pet này sẽ không bao giờ bị bán",

    ["No three matching pets"] = "Không đủ 3 pet trùng khớp",
    ["Fuse 3 same pets into an egg, nonstop"] = "Ghép 3 pet cùng loại thành 1 trứng liên tục",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Dung Hợp",
    ["Pets To Use"] = "Loại Pet Sử Dụng",
    ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Cần Dung Hợp",
    ["Only fuse these species (empty = all)"] = "Chỉ ghép loài này (trống = tất cả)",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến",
    ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ",
    ["Take out pets that can't make a set"] = "Đẩy ra các pet không thể ghép đủ bộ 3",

    ["Auto Favorite Pet"] = "Tự Động Khóa Pet",
    ["Favorite pets matching the rules below"] = "Khóa các pet khớp quy tắc bên dưới",
    ["Favorite Pets Now"] = "Khóa Pet Ngay",
    ["Favorite matching pets once"] = "Khóa các pet khớp điều kiện một lần",
    ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Pass any check or all checks"] = "Thỏa mãn một hoặc tất cả điều kiện",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min",
    ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "Khóa pet từ độ hiếm đã chọn trở lên (Off = bỏ qua)",
    ["Favorite Mutations"] = "Đột Biến Cần Khóa",
    ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (trống = bỏ qua)",
    ["Min Favorite Value"] = "Giá Trị Khóa Min",
    ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Các Loài Này",
    ["Always favorite these species"] = "Luôn luôn khóa những loài này",
    ["Auto Favorite Equipped"] = "Tự Khóa Pet Đang Dùng",
    ["Keep equipped pets favorited"] = "Luôn giữ pet đang trang bị được khóa",
    ["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Pet Đang Dùng",
    ["Unfavorite equipped pets not in the rules"] = "Mở khóa pet đang trang bị nếu không đúng quy tắc",
    ["Favorite Equipped Now"] = "Khóa Pet Đang Dùng Ngay",
    ["Favorite all equipped pets once"] = "Khóa tất cả pet đang trang bị một lần",
    ["Unfavorite Equipped Now"] = "Bỏ Khóa Pet Đang Dùng Ngay",
    ["Unfavorite all equipped pets once"] = "Mở khóa tất cả pet đang trang bị một lần",

    ["Auto Mech Boss"] = "Tự Động Đánh Boss Robot",
    ["Mech Tween Speed"] = "Tốc Độ Bay Đánh Boss",
    ["Main Weapon Hold"] = "Thời Gian Giữ Vũ Khí Chính",
    ["Scrambler Hold"] = "Thời Gian Giữ Súng Biến Đổi",
    ["Swap Two Weapons"] = "Tự Đổi Qua Lại 2 Vũ Khí",
    ["Boss Server Hop"] = "Tự Đổi Server Săn Boss",
    ["After each boss, hops to a less crowded server to fight again"] = "Sau mỗi boss, đổi sang server vắng hơn để đánh tiếp",
    ["Keep Hopping For"] = "Thời Gian Đổi Server Liên Tục",
    ["Keeps fighting every boss it finds and hopping for this long"] = "Liên tục săn boss tìm được và đổi server trong thời gian này",
    ["Auto Claim Mastery"] = "Tự Nhận Thưởng Tinh Thông Boss",
    ["Claims Boss Mastery rewards as soon as they unlock"] = "Tự nhận thưởng Tinh Thông Boss ngay khi mở khóa",
    ["Lab Banners"] = "Biểu Ngữ Phòng Lab",
    ["Only trade and steal for these banners (empty = all)"] = "Chỉ đổi và cướp các biểu ngữ này (trống = tất cả)",
    ["Auto Lab Trade-In"] = "Tự Đổi Đồ Phòng Thí Nghiệm",
    ["Auto Reroll Lab Recipe"] = "Tự Đổi Công Thức Phòng Lab",
    ["Auto Place Lab Reward Eggs"] = "Tự Đặt Trứng Thưởng Lab",
    ["Places the reward eggs from Lab trades"] = "Tự động đặt trứng thưởng nhận từ đổi đồ phòng lab",
    ["Auto Buy Scramble Shop"] = "Tự Mua Shop Dr. Scramble",
    ["Buy the picked items with Samples"] = "Dùng Mẫu Vật (Samples) mua các vật phẩm đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble",
    ["Keep Samples"] = "Giữ Lại Mẫu Vật Tối Thiểu",
    ["Never spend below this many Samples"] = "Không bao giờ tiêu hao dưới mức mẫu vật này",
    ["Auto Use Scrambled"] = "Tự Dùng Thuốc Biến Đổi Scrambled",
    ["Turn it on to start applying Scrambled"] = "Bật lên để bắt đầu áp dụng thuốc Scrambled",
    ["Auto Buy Scrambled"] = "Tự Mua Thêm Scrambled Khi Hết",
    ["Buy another Scrambled from the event shop when you run out"] = "Tự mua thêm Scrambled từ shop sự kiện khi dùng hết",
    ["Mutation Min Rarity"] = "Độ Hiếm Đột Biến Min",
    ["Only eggs of this rarity and above are used"] = "Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Value"] = "Giá Trị Đột Biến Min",
    ["Mutation Priority"] = "Ưu Tiên Đột Biến",
    ["Which egg gets the consumable first"] = "Trứng nào được ưu tiên dùng thuốc trước",
    ["Mutation Target Eggs"] = "Mục Tiêu Trứng Đột Biến",
    ["Only use the consumable on these eggs (empty = all)"] = "Chỉ dùng thuốc lên các trứng này (trống = tất cả)",
    ["Auto Wisp"] = "Tự Động Nhặt Wisp",
    ["Auto Banjo Cricket"] = "Tự Động Bắt Dế Banjo",

    ["Chase Settings"] = "Cài Đặt Đuổi Đánh",
    ["Chase Cài Đặt"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh",
    ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Đòn Đánh (Hit Lead)",
    ["Stand further ahead of the target (i.e. or closer to them)"] = "Đứng đón đầu mục tiêu xa hơn (hoặc áp sát gần hơn)",
    ["Hit Sweep"] = "Góc Quét Đòn Đánh (Hit Sweep)",
    ["How far you swipe back and forth in front of the target"] = "Khoảng cách vung vũ khí quét qua lại trước mục tiêu",
    ["Add/Remove Hits On Quick Bar 2"] = "Thêm/Bỏ Nút Đánh Vào Quick Bar 2",
    ["Pin or unpin the hit toggles on Quick Bar 2"] = "Ghim hoặc bỏ ghim các nút đánh trên Quick Bar 2",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất",
    ["Auto Hit Egg Holders"] = "Tự Đánh Người Đang Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định",
    ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
    ["Instant Prompts"] = "Tương Tác Phím Nhanh (Instant E)",
    ["Speed Boost"] = "Tăng Tốc Chạy",
    ["Boost Speed"] = "Tốc Độ Tăng Tốc",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)",
    ["Makes you invisible to other players"] = "Làm bạn vô hình trước người chơi khác",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)",
    ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không thể bắt được bạn",

    ["ESP Eggs"] = "ESP Trứng",
    ["ESP Fixed Size"] = "Cỡ ESP Cố Định",
    ["ESP Own Base Eggs"] = "Hiện Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiển thị cả trứng đã đặt tại căn cứ của bạn",
    ["ESP Min Rarity"] = "Độ Hiếm ESP Min",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm đã chọn trở lên",
    ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["Min ESP Value"] = "Giá Trị ESP Min",
    ["ESP Egg Size"] = "Cỡ ESP Trứng",
    ["ESP Guards"] = "ESP Vệ Sĩ",
    ["ESP Guard Size"] = "Cỡ ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi",
    ["ESP Players"] = "ESP Người Chơi",
    ["ESP Player Info"] = "Thông Tin ESP Người Chơi",
    ["ESP Player Size"] = "Cỡ ESP Người Chơi",

    ["Search eggs..."] = "Tìm kiếm trứng...",
    ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",
    ["Biohazard Pets"] = "Pet Phóng Xạ (Biohazard)",
    ["CURRENT RECIPE"] = "CÔNG THỨC HIỆN TẠI",
    ["REWARD ODDS - BIOHAZARD PETS"] = "TỈ LỆ THƯỞNG - PET PHÓNG XẠ",
    ["Chase pet"] = "Đuổi bắt pet",
    ["Machine is empty"] = "Máy đang trống",
    ["Load 3 pets of the same species to see the result odds"] = "Đặt 3 pet cùng loài vào máy để xem tỉ lệ kết quả",
    ["Sort By"] = "Sắp Xếp Theo",
    ["Preview Card"] = "Thẻ Xem Trước",

    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng (Trail)",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng có sẵn khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim"] = "Tự Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền tích lũy offline & thưởng sách pet",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Sách Pet",
    ["Claim index rewards as soon as they unlock"] = "Tự động nhận thưởng sách ngay khi mở khóa",

    ["Auto Load Script"] = "Tự Động Nạp Script",
    ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Server Hop"] = "Đổi Server",
    ["Job ID"] = "Mã Phòng (Job ID)",
    ["Paste a server Job ID..."] = "Dán mã Job ID của server...",
    ["Join Job ID"] = "Vào Bằng Job ID",
    ["Copy Current Job ID"] = "Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Server",
    ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",

    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D",
    ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",

    ["Joins new servers to find eggs that match the filters below"] = "Tự đổi server để tìm trứng khớp bộ lọc bên dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Server để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server",
    ["Rarity To Wait For"] = "Độ Hiếm Cần Giữ Chân",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ nếu xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với mục Tự Động Cướp",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Value To Find"] = "Giá Trị Trứng Min Cần Tìm",
    ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu",
    ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng",
    ["Post every egg you bring home"] = "Gửi thông báo mỗi quả trứng mang về thành công",
    ["selected"] = "đã chọn",

    -- ==================== SỰ KIỆN HALLOWEEN ====================
    ["HALLOWEEN"] = "HALLOWEEN",
    ["Halloween"] = "Halloween",
    ["HALLOWEEN DIMENSION"] = "CHIỀU KHÔNG GIAN HALLOWEEN",
    ["Halloween Dimension"] = "Chiều Không Gian Halloween",
    ["Auto steal Halloween eggs"] = "Tự động cướp trứng Halloween",
    ["Instant steal Halloween eggs"] = "Cướp tức thì trứng Halloween",
    ["Steal speed"] = "Tốc độ cướp",
    ["Halloween eggs"] = "Trứng Halloween",
    ["Halloween rarities"] = "Độ hiếm Halloween",
    ["Auto Pumpkin Moon"] = "Tự động Pumpkin Moon",
    ["Pumpkin Moon"] = "Pumpkin Moon",
    ["MONSTERS"] = "QUÁI VẬT",
    ["Monsters"] = "Quái vật",
    ["Auto farm monsters"] = "Tự động farm quái",
    ["Monster order"] = "Thứ tự quái",
    ["PHANTOM EXPRESS"] = "PHANTOM EXPRESS",
    ["Phantom Express"] = "Phantom Express",
    ["TRAIN"] = "TÀU",
    ["SOULS"] = "LINH HỒN",
    ["Not here"] = "Không ở đây",
    ["Walk speed"] = "Tốc độ đi",
    ["Sử dụng vũ khí"] = "Sử dụng vũ khí",
    ["Use weapons"] = "Sử dụng vũ khí",
    ["Sự Kiện"] = "Sự Kiện",
    ["Event"] = "Sự Kiện",
    ["Sao Băng"] = "Sao Băng",
    ["Bắt Bướm"] = "Bắt Bướm",
    ["Admin (AA)"] = "Admin (AA)",
    ["Đang rảnh"] = "Đang rảnh"
}

local DYNAMIC_PATTERNS = {
    {
        pattern = "ALL (%d+)",
        format = function(lang, c) return lang == "VI" and ("TẤT CẢ " .. c) or ("ALL " .. c) end
    },
    {
        pattern = "READY (%d+)",
        format = function(lang, c) return lang == "VI" and ("SẴN SÀNG " .. c) or ("READY " .. c) end
    },
    {
        pattern = "GROWING (%d+)",
        format = function(lang, c) return lang == "VI" and ("ĐANG LỚN " .. c) or ("GROWING " .. c) end
    },
    {
        pattern = "IN BAG (%d+)",
        format = function(lang, c) return lang == "VI" and ("TRONG TÚI " .. c) or ("IN BAG " .. c) end
    },
    {
        pattern = "#(%d+) of (%d+) eggs by value",
        format = function(lang, r, total) return lang == "VI" and string.format("Hạng #%s/%s trứng theo giá trị", r, total) or string.format("#%s of %s eggs by value", r, total) end
    },
    {
        pattern = "1 in ([%d%.]+)",
        format = function(lang, val) return lang == "VI" and ("Tỉ lệ 1/" .. val) or ("1 in " .. val) end
    },
    {
        pattern = "Ends in (%d+h %d+m %d+s)",
        format = function(lang, tStr) return lang == "VI" and ("Kết thúc sau " .. tStr) or ("Ends in " .. tStr) end
    },
    {
        pattern = "in (%d+h %d+m)",
        format = function(lang, tStr) return lang == "VI" and ("sau " .. tStr) or ("in " .. tStr) end
    },
    {
        pattern = "Next Racing Event in (%d+:%d+)",
        format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Đua xe tiếp theo sau " .. timeStr) or ("Next Racing Event in " .. timeStr) end
    },
    {
        pattern = "Banner chance (%d+%.?%d*%%)",
        format = function(lang, cStr) return lang == "VI" and ("Tỉ lệ Banner " .. cStr) or ("Banner chance " .. cStr) end
    },
    {
        pattern = "Pity (%d+)/(%d+)",
        format = function(lang, p1, p2) return lang == "VI" and string.format("Bảo hiểm %s/%s", p1, p2) or string.format("Pity %s/%s", p1, p2) end
    },
    {
        pattern = "Free rerolls (%d+)",
        format = function(lang, rStr) return lang == "VI" and ("Đổi miễn phí " .. rStr) or ("Free rerolls " .. rStr) end
    },
    {
        pattern = "rotates in (%d+:%d+)",
        format = function(lang, timeStr) return lang == "VI" and ("xoay vòng sau " .. timeStr) or ("rotates in " .. timeStr) end
    },
    {
        pattern = "Eggs placed (%d+)/(%d+) %- (%d+)/(%d+) pets equipped, (%d+) in bag",
        format = function(lang, p1, p2, p3, p4, p5)
            if lang == "VI" then
                return string.format("Trứng đã đặt %s/%s - %s/%s pet trang bị, %s trong túi", p1, p2, p3, p4, p5)
            end
            return string.format("Eggs placed %s/%s - %s/%s pets equipped, %s in bag", p1, p2, p3, p4, p5)
        end
    },
    {
        pattern = "Pet matches %- (%d+) pets? for %$(.+)",
        format = function(lang, count, val)
            if lang == "VI" then return string.format("Khớp pet - %s pet giá $%s", count, val) end
            return string.format("Pet matches - %s pets for $%s", count, val)
        end
    },
    {
        pattern = "Egg matches %- (%d+) eggs? for %$(.+)",
        format = function(lang, count, val)
            if lang == "VI" then return string.format("Khớp trứng - %s trứng giá $%s", count, val) end
            return string.format("Egg matches - %s eggs for $%s", count, val)
        end
    },
    {
        pattern = "Lab egg matches %- (%d+) eggs? for %$(.+)",
        format = function(lang, count, val)
            if lang == "VI" then return string.format("Khớp trứng Lab - %s trứng giá $%s", count, val) end
            return string.format("Lab egg matches - %s eggs for $%s", count, val)
        end
    },
    {
        pattern = "Favorite matches %- (%d+) pets?, (%d+) to mark %| (%d+) favorited",
        format = function(lang, c1, c2, c3)
            if lang == "VI" then return string.format("Khớp yêu thích - %s pet, %s cần lưu | %s đã khóa", c1, c2, c3) end
            return string.format("Favorite matches - %s pets, %s to mark | %s favorited", c1, c2, c3)
        end
    },
    {
        pattern = "Charges (%d+) Eggs (%d+)/(%d+) Tries (%d+) Applied (%d+)",
        format = function(lang, c, e1, e2, t, a)
            if lang == "VI" then return string.format("Số lần sạc %s Trứng %s/%s Thử %s Đã dùng %s", c, e1, e2, t, a) end
            return string.format("Charges %s Eggs %s/%s Tries %s Applied %s", c, e1, e2, t, a)
        end
    },
    {
        pattern = "Players (%d+)/(%d+)",
        format = function(lang, p1, p2) return lang == "VI" and string.format("Người chơi %s/%s", p1, p2) or string.format("Players %s/%s", p1, p2) end
    },
    {
        pattern = "Next Mech portal in (%d+:%d+)",
        format = function(lang, timeStr) return lang == "VI" and ("Cổng Robot mở sau " .. timeStr) or ("Next Mech portal in " .. timeStr) end
    },
    {
        pattern = "Next Butterfly Bloom in (%d+:%d+)",
        format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Bướm nở sau " .. timeStr) or ("Next Butterfly Bloom in " .. timeStr) end
    },
    {
        pattern = "Butterfly Bloom live, (%d+:%d+) left",
        format = function(lang, timeStr) return lang == "VI" and ("Sự kiện Bướm đang diễn ra, còn " .. timeStr) or ("Butterfly Bloom live, " .. timeStr .. " left") end
    },
    {
        pattern = "Caught (.+)! %((%d+) owned%)",
        format = function(lang, name, count) return lang == "VI" and string.format("Đã bắt %s! (Đang có %s con)", name, count) or string.format("Caught %s! (%s owned)", name, count) end
    }
}

local SortedVI = {}
for en, vi in pairs(MAP_VI) do table.insert(SortedVI, {en = en, out = vi, len = #en}) end
table.sort(SortedVI, function(a, b) return a.len > b.len end)

-- ==================== 3. LÕI DỊCH THUẬT SIÊU TỐC O(1) ====================
local function translateText(raw)
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if currentLanguage == "EN" then
        local res = replaceAll(raw, "Chilli Hub", "MK Hub V4 Pro")
        res = replaceAll(res, "Venyx", "MK Panel")
        FastCache[cacheKey] = res
        return res
    end

    local trimmed = raw:match("^%s*(.-)%s*$") or raw

    if EXACT_MATCH_VI[trimmed] then
        local res = raw:gsub(trimmed, EXACT_MATCH_VI[trimmed], 1)
        FastCache[cacheKey] = res
        return res
    end

    local result = raw
    local matched = false

    for _, item in ipairs(DYNAMIC_PATTERNS) do
        if result:find(item.pattern) then
            result = result:gsub(item.pattern, function(...)
                return item.format(currentLanguage, ...)
            end)
            matched = true
        end
    end

    for _, item in ipairs(SortedVI) do
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

-- ==================== 4. INJECT ASSET BACKGROUND DARI CUSTOM ID ====================
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
        bgImg.ImageTransparency = 0.25 -- Keseimbangan gambar & kejelasan teks
        bgImg.ScaleType = Enum.ScaleType.Slice
        bgImg.ZIndex = 0
        bgImg.Parent = mainFrame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = bgImg
    end
end

local function inspectAndApplySoftBlue(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton")) then return end
    if inst:FindFirstAncestor("MK_Liquid_Capsule") or inst:FindFirstAncestor("MK_Rainbow_Notice") then return end

    local textRaw = inst.Text:lower():match("^%s*(.-)%s*$") or ""

    if textRaw:find("chilli hub") or textRaw:find("mk hub") then
        local headerFrame = inst:FindFirstAncestorOfClass("Frame")
        if headerFrame then
            applyCustomBackground(headerFrame.Parent)
        end
        return
    end
end

-- ==================== 5. BẢNG THÔNG BÁO XỊN XÒ VIỀN CẦU VỒNG (MK RAINBOW MODAL) ====================
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

    -- Background Image Custom di Modal Notifikasi
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
    BadgeLabel.Text = "🛠️ THÔNG BÁO UPDATE"
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
    Message.Text = "Script MK Hub V4 Pro is ready to use!"
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
    ConfirmBtn.Text = "ĐÃ HIỂU"
    ConfirmBtn.Font = Enum.Font.GothamBold
    ConfirmBtn.TextSize = 13
    ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmBtn.Parent = Card

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = ConfirmBtn

    updateNoticeLanguage = function(lang)
        if lang == "VI" then
            BadgeLabel.Text = "🛠️ THÔNG BÁO UPDATE"
            Message.Text = "Script MK Hub V4 Pro is ready to use!"
            ConfirmBtn.Text = "ĐÃ HIỂU"
        else
            BadgeLabel.Text = "🛠️ UPDATE NOTICE"
            Message.Text = "Script MK Hub V4 Pro is ready to use!"
            ConfirmBtn.Text = "UNDERSTOOD"
        end
    end

    ConfirmBtn.MouseButton1Click:Connect(function()
        if rotConn then rotConn:Disconnect() end
        local fadeTween = TweenService:Create(Card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.55, 0),
            BackgroundTransparency = 1
        })
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
    Capsule.BorderSizePixel = 0
    Capsule.Parent = ScreenGui

    local CapsuleCorner = Instance.new("UICorner")
    CapsuleCorner.CornerRadius = UDim.new(1, 0)
    CapsuleCorner.Parent = Capsule

    local BtnVI = Instance.new("TextButton")
    BtnVI.Name = "BtnVI"
    BtnVI.Size = UDim2.new(0, 84, 1, 0)
    BtnVI.Position = UDim2.new(0, 4, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 TIẾNG VIỆT"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10
    BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnVI.Parent = Capsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Name = "BtnEN"
    BtnEN.Size = UDim2.new(0, 84, 1, 0)
    BtnEN.Position = UDim2.new(1, -88, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10
    BtnEN.TextColor3 = Color3.fromRGB(145, 160, 185)
    BtnEN.Parent = Capsule

    local function switchMode(target)
        if currentLanguage == target then return end
        currentLanguage = target
        updateAllActive()
        if updateNoticeLanguage then updateNoticeLanguage(target) end
    end

    BtnVI.MouseButton1Click:Connect(function() switchMode("VI") end)
    BtnEN.MouseButton1Click:Connect(function() switchMode("EN") end)
end

-- ==================== 7. MK PANEL LOADSTRING OVERRIDE ====================
local CHILLI_PANEL_LOADSTRING = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/mikhuji359-pixel/stealanegg/refs/heads/main/hub.lua"))()'
local OLD_VENYX_URL_SNIPPET = "tienkhanh1/Venyx"

local function patchChilliPanelElement(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    local raw = inst.Text or ""
    if raw:find(OLD_VENYX_URL_SNIPPET, 1, true) or (raw:find("loadstring", 1, true) and raw:find("VenyxHub", 1, true)) then
        if inst.Text ~= CHILLI_PANEL_LOADSTRING then
            inst:SetAttribute("__IsTranslating", true)
            pcall(function() inst.Text = CHILLI_PANEL_LOADSTRING end)
            inst:SetAttribute("__IsTranslating", false)
        end
    end
end

-- ==================== 8. SCANNER ENGINE ====================
task.delay(2.5, function()
    createRainbowNoticeUI()
    createLiquidCapsuleUI()

    local searchRoots = { gethui and gethui(), CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }

    local function scanUIChunked(parent)
        local children = parent:GetChildren()
        for i, desc in ipairs(children) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                hookElement(desc)
                inspectAndApplySoftBlue(desc)
                patchChilliPanelElement(desc)
            end
            if i % 30 == 0 then RunService.RenderStepped:Wait() end
            scanUIChunked(desc)
        end
    end

    for _, root in ipairs(searchRoots) do
        if root then pcall(function() scanUIChunked(root) end) end
    end
end)
