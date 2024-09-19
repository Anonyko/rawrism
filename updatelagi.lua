repeat
    task.wait()
until game:IsLoaded()
if hwid == "16003a41d764ac40af135c8682e2c1e1048718aeeb975093dab59604b1d81b2b" then
    local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local lives = workspace:WaitForChild("Lives")
local TweenService = game:GetService("TweenService")
local PlayerGui = Client.PlayerGui
local UIStats = loadstring(
    game:HttpGet("https://raw.githubusercontent.com/Anonyko/rawrism/main/biarkancintatumbuhh.lua"))()
UIStats:updateCountdownText("samarium")

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Samarium Project | discord.gg/samarium",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({
        Title = "Main",
        Icon = "bar-chart"
    }),
    Farm = Window:AddTab({
        Title = "Autofarm",
        Icon = "truck"
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    })
}
Window:SelectTab(1)

shared.TotalCash = "0"
shared.TotalEarnings = "0"

local InfoSec = Tabs.Main:AddSection("Information")

local ClientCash = InfoSec:AddParagraph({
    Title = "Balance",
    Content = ""
})
local ClientEarnings = InfoSec:AddParagraph({
    Title = "Cash Earned",
    Content = ""
})
shared.ClientTime = InfoSec:AddParagraph({
    Title = "Time Elapsed",
    Content = "You Haven't Start AutoFarming"
})
shared.ClientInformation = InfoSec:AddParagraph({
    Title = "Status",
    Content = "AutoFarm Is Idle"
})

task.spawn(function()
    while task.wait() do
        shared.TotalCash = PlayerGui.Main.Container.Hub.CashFrame.Frame.TextLabel.Text
        shared.TotalEarnings = PlayerGui.PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            ClientCash:SetDesc(shared.TotalCash)
            UIStats:updateTotalEarningsText(shared.TotalEarnings)
            UIStats:updateTotalMoneyText(shared.TotalCash)
            ClientEarnings:SetDesc(shared.TotalEarnings)
        end)
    end
end)

shared.FarmConfig = {
    TargetMoney = 9999999999999999999,
    webhookLinks = "N/A",
    TeleportCooldown = 0.5,
    ElapsedTime = ""
}

local FarmCfg = Tabs.Farm:AddSection("Webhook Configuration")

FarmCfg:AddInput("Input", {
    Title = "Target Cash",
    Description = "Amount of cash you want",
    Default = "",
    Placeholder = 99999999999999,
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        shared.FarmConfig.TargetMoney = tonumber(Value)
    end
})

FarmCfg:AddInput("Input", {
    Title = "Delay",
    Description = "Minimize chance of crash",
    Default = 0.1,
    Placeholder = 0.1,
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        shared.FarmConfig.TeleportCooldown = tonumber(Value)
    end
})

local function AntiAFK()
    local AFKVal = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        task.wait()
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end)
end

local AutoFarm = Tabs.Farm:AddSection("Auto Farming")

AutoFarm:AddButton({
    Title = "Start Auto Farm",
    Description = "Samarium AutoFarm [unstopabble]",
    Callback = function()
        pcall(function()
            PerformAction("FireJob")
            task.wait(0.5)
            shared.ClientInformation:SetDesc("Getting Job")
            PerformAction("setDestinationToSemarang")
            task.wait(0.5)
            shared.ClientInformation:SetDesc("Setting Destination")
            PerformAction("SpawnMinigunTruck")
            task.wait(0.5)
            task.spawn(function()
                PerformAction("sTimer")
            end)
            PerformAction("newFarming")
        end)
    end
})

local FPSec = Tabs.Settings:AddSection("FPS")
FPSec:AddButton({
    Title = "FPS Boost",
    Description = "Deletes useless shit",
    Callback = function()
        destroyListedObjects()
    end
})

local GameSec = Tabs.Settings:AddSection("Game")

GameSec:AddButton({
    Title = "Rejoin",
    Description = "Rejoins the game [doesn't work in priv servers]",
    Callback = function()
        game:GetService("TeleportService"):Teleport(6911148748, game.Players.LocalPlayer)
    end
})

function destroyListedObjects()
    local objectsToDestroy = {"AmbientLightRevamp", "ChristmasEvent", "Map.TrafficLight", "Map.Tree", "Map.17",
                              "Map.Chirstmas", "Map.Ramadhan", "Map.RoadLight", "Map.PalangTol", "Map.OwnableHouse",
                              "Map.Hill", "Map.Ocean1", "Map.Ocean2"}

    for _, objectName in ipairs(objectsToDestroy) do
        local object
        if objectName:find("%.") then
            local parts = {}
            for part in objectName:gmatch("[^%.]+") do
                table.insert(parts, part)
            end

            object = workspace
            for _, partName in ipairs(parts) do
                object = object:FindFirstChild(partName)
                if not object then
                    break
                end
            end
        else
            object = workspace:FindFirstChild(objectName)
        end

        if object then
            object:Destroy()
        else
            warn(objectName .. " not found in workspace")
        end
    end
end
function CarTweenSss(Pos, callback)
    local CFrameVal = Instance.new("CFrameValue")
    CFrameVal.Parent = workspace

    local Vehicle = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name .. "sCar")
    if not Vehicle then
        warn("Vehicle not found.")
        return
    end

    local Tinfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0)

    CFrameVal.Value = Vehicle:GetPivot()

    local NewPosition = Pos
    local Tween = TweenService:Create(CFrameVal, Tinfo, {
        Value = NewPosition
    })
    Tween:Play()

    CFrameVal.Changed:Connect(function(Position)
        Vehicle:PivotTo(Position)
    end)

    Tween.Completed:Wait()
    if callback ~= nil then
        callback()
    end
    CFrameVal:Destroy()
end
function TpRojodTween(Pos, callback)
    local CFrameVal = Instance.new("CFrameValue")
    CFrameVal.Parent = workspace

    local Vehicle = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name .. "sCar")
    if not Vehicle then
        warn("Vehicle not found.")
        return
    end

    local Tinfo = TweenInfo.new(54, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0)

    CFrameVal.Value = Vehicle:GetPivot()

    local NewPosition = Pos
    local Tween = TweenService:Create(CFrameVal, Tinfo, {
        Value = NewPosition
    })
    Tween:Play()

    CFrameVal.Changed:Connect(function(Position)
        Vehicle:PivotTo(Position)
    end)

    Tween.Completed:Wait()
    if callback ~= nil then
        callback()
    end
    CFrameVal:Destroy()
end
function CarTween(Pos, callback)
    local CFrameVal = Instance.new("CFrameValue")
    CFrameVal.Parent = workspace

    local Vehicle = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name .. "sCar")
    if not Vehicle then
        warn("Vehicle not found.")
        return
    end

    local Tinfo = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0)

    CFrameVal.Value = Vehicle:GetPivot()

    local NewPosition = Pos
    local Tween = TweenService:Create(CFrameVal, Tinfo, {
        Value = NewPosition
    })
    Tween:Play()

    CFrameVal.Changed:Connect(function(Position)
        Vehicle:PivotTo(Position)
    end)

    Tween.Completed:Wait()
    if callback ~= nil then
        callback()
    end
    CFrameVal:Destroy()
end

function PerformAction(actionType)
    local LP = game.Players.LocalPlayer
    function Tween(cframe)
        local HumanoidRootPart = LP.Character.HumanoidRootPart
        repeat
            if not HumanoidRootPart or not cframe then
                print("Error: HumanoidRootPart or cframe is missing")
            end
        until HumanoidRootPart and cframe
        TweenService:Create(HumanoidRootPart, TweenInfo.new(0.7), {
            CFrame = cframe
        }):Play()
    end
    function GetWaypointName()
        local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
        local waypointLabel = assert(waypoint:FindFirstChild("BillboardGui") and
                                         waypoint.BillboardGui:FindFirstChild("TextLabel"), "Waypoint label not found!")
        return waypointLabel.Text
    end

    function cleanMoneyString(str)
        return str:gsub("RP. ", ""):gsub(",", ""):gsub("%.", ""):gsub("+", "")
    end

    function formatRupiah(num)
        num = math.floor(num)
        local formatted = tostring(num)
        local result = ""

        local count = 0
        for i = #formatted, 1, -1 do
            result = formatted:sub(i, i) .. result
            count = count + 1
            if count % 3 == 0 and i ~= 1 then
                result = "," .. result
            end
        end

        return "RP. " .. result
    end

    function estimateTime(currentMoney, targetMoney, moneyPerTeleport)
        local moneyNeeded = targetMoney - currentMoney
        if moneyNeeded <= 0 then
            return 0, 0, 0
        end

        local timeNeeded = math.ceil(moneyNeeded / moneyPerTeleport) * 50
        return math.floor(timeNeeded / 3600), math.floor((timeNeeded % 3600) / 60), math.floor(timeNeeded % 60)
    end

    function getCurrentDateTime()
        local date = os.date("%d/%m/%Y")
        local time = os.date("%I:%M %p")
        return "📅Date " .. date .. " ⏰Time " .. time
    end

    function FireJob()
        recallJob()
        local TargetTween = CFrame.new(-21799.8, 1042.65, -26797.7)
        game.Workspace.Gravity = 0
        Tween(TargetTween)
        Tween(TargetTween)
        Tween(TargetTween)
        Tween(TargetTween)
        Tween(TargetTween)
        Tween(TargetTween)
        Tween(TargetTween)
    end

    function setDestinationToSemarang()
        repeat
            wait(0.5)
            game.Workspace.Gravity = 10
            local Waypoint = game.Workspace.Etc.Waypoint:FindFirstChild("Waypoint")
            local WaypointLabel = Waypoint:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")
            if WaypointLabel.Text ~= "Rojod Semarang" then
                local TargetTween = CFrame.new(-21799.8, 1042.65, -26797.7)
                Tween(TargetTween)
                recallJob()
                fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            else
                local TargetTween = CFrame.new(-21799.8, 1042.65, -26797.7)
                Tween(TargetTween)
            end

        until WaypointLabel.Text == "Rojod Semarang"
    end

    function SpawnMinigunTruck()
        local waypointPosition = game.Workspace.Etc.Job.Truck.Spawner.Part.Position
        Tween(CFrame.new(waypointPosition))
        fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)

        repeat
            wait(1)
            Tween(CFrame.new(waypointPosition))
            fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
            local miniTruck = workspace.Vehicles:WaitForChild(Players.LocalPlayer.Name .. "sCar"):FindFirstChild("Cost")

            if not miniTruck then
                repeat
                    wait()
                until miniTruck
            end

            if miniTruck.Value ~= 401000 then
                Tween(CFrame.new(waypointPosition))
                fireproximityprompt(workspace.Etc.Job.Truck.Spawner.Part.Prompt)
            end
        until miniTruck.Value == 401000

        local vehicle = workspace.Vehicles:FindFirstChild(Players.LocalPlayer.Name .. "sCar")

        wait(3.5)

        vehicle.DriveSeat:Sit(game:GetService("Players").LocalPlayer.Character.Humanoid)
        shared.ClientInformation:SetDesc("Spawned Minigun truck")
        print("Truck ready to teleport")
    end

    function settingsDestinationTwo()
        local foundrojod = false
        local playerCar = workspace.Vehicles:FindFirstChild(Players.LocalPlayer.Name .. "sCar")
        CarTweenSss(CFrame.new(-21797.724609375, 1044.722900390625, -26797.177734375))

        repeat
            task.wait(0.5)
            local Waypoint = game.Workspace.Etc.Waypoint:FindFirstChild("Waypoint")
            local WaypointLabel = Waypoint:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")

            if WaypointLabel.Text ~= "Rojod Semarang" then
                recallJob()
                fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
                game.Workspace.Gravity = 10
            end
        until WaypointLabel.Text == "Rojod Semarang"
    end

    function newFarming()
        local workspace = game:GetService("Workspace")
        local playerCar = workspace.Vehicles:FindFirstChild(Players.LocalPlayer.Name .. "sCar")
        local character = Client.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.SeatPart == nil or humanoid.SeatPart.Name ~= "DriveSeat" then
                    return
                end
        task.spawn(function()
            while wait() do
                local GameCash = game:GetService("Players").LocalPlayer.PlayerGui.Main.Container.Hub.CashFrame.Frame
                                     .TextLabel.Text
                local CleanCurrentMoney = cleanMoneyString(GameCash)
                local CleanCurrentNumeric = tonumber(CleanCurrentMoney)

                if shared.FarmConfig.TargetMoney <= CleanCurrentNumeric then
                    break
                end

                countdown(shared.FarmConfig.TeleportCooldown)

                local destination = GetWaypointName()

                local waypointGui = workspace.Etc.Waypoint.Waypoint:FindFirstChild("BillboardGui")
                game.Workspace.Gravity = 10
                local Waypoint = waypointGui and waypointGui.TextLabel.Text
                CarTweenSss(CFrame.new(-21799.8, 1042.65, -26797.7))
                
                task.wait(50)
                game.Workspace.Gravity = 0
                CarTweenSss(CFrame.new(-50889.6602, 1017.86719, -86514.7969), function()
                    shared.ClientInformation:SetDesc("Started new farm")
                end)
                game.Workspace.Gravity = 10
                task.wait(4)
                AntiAFK()
                settingsDestinationTwo()
            end
        end)
    end

    function countdown(duration)
        for i = duration, 0, -1 do
            task.wait(1)
        end
    end

    function sTimer()
        local jobTime = tick()
        local startTime = os.date("%H:%M:%S")
        local startDate = os.date("%Y-%m-%d")

        while task.wait() do
            local elapsedTime = tick() - jobTime
            local hours = math.floor(elapsedTime / 3600)
            local minutes = math.floor((elapsedTime % 3600) / 60)
            local seconds = math.floor(elapsedTime % 60)

            local timeText = string.format("%02d.%02d.%02d", hours, minutes, seconds)
            shared.FarmConfig.ElapsedTime = timeText
            UIStats:updateTotalTimeText(timeText)
            shared.ClientTime:SetDesc(timeText)
        end
    end

    function recallJob()
        local args = {"Truck"}
        game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
        local playerCar = workspace.Vehicles:FindFirstChild(Players.LocalPlayer.Name .. "sCar")
        CarTweenSss(CFrame.new(-21800, 1045, -26792))
    end

    if actionType == "FireJob" then
        FireJob()
    elseif actionType == "setDestinationToSemarang" then
        setDestinationToSemarang()
    elseif actionType == "SpawnMinigunTruck" then
        SpawnMinigunTruck()
    elseif actionType == "settingsDestinationTwo" then
        settingsDestinationTwo()
    elseif actionType == "newFarming" then
        newFarming()
    elseif actionType == "countdown" then
        countdown(shared.FarmConfig.TeleportCooldown)
    elseif actionType == "sTimer" then
        sTimer()
    elseif actionType == "recallJob" then
        recallJob()
    end
end

task.spawn(function()
    while task.wait() do
        local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        if not HumanoidRootPart then
            task.wait(1)
            print("HumanoidRootPart is nil")
        end
    end
end)

local function childAdded(child)
    if child.Name == Players.LocalPlayer.Name then
        local Waypoint = game.Workspace.Etc.Waypoint:FindFirstChild("Waypoint")
        local WaypointLabel = Waypoint:FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")
        if (WaypointLabel.Text ~= "Go to waypoint to start job") then
            pcall(function()
                task.spawn(function()
                end)
                PerformAction("FireJob")
                task.wait(0.5)
                shared.ClientInformation:SetDesc("Getting Job")
                PerformAction("setDestinationToSemarang")
                task.wait(0.5)
                shared.ClientInformation:SetDesc("Setting Destination")
                PerformAction("SpawnMinigunTruck")
                task.wait(0.5)
                PerformAction("newFarming")
            end)
        end
    else
        PerformAction("FireJob")
        task.wait(0.5)
        PerformAction("setDestinationToSemarang")
        task.wait(0.5)
        PerformAction("SpawnMinigunTruck")
        task.wait(0.5)
        PerformAction("newFarming")
    end
end

local function childRemoved(child)
    if child.Name == Players.LocalPlayer.Name then
        print(Players.LocalPlayer.Name .. " has been removed")
    end
end

lives.ChildAdded:Connect(childAdded)
lives.ChildRemoved:Connect(childRemoved)

local function gacorSay()
    pcall(function()
        PerformAction("FireJob")
        task.wait(0.5)
        shared.ClientInformation:SetDesc("Getting Job")
        PerformAction("setDestinationToSemarang")
        task.wait(0.5)
        shared.ClientInformation:SetDesc("Setting Destination")
        PerformAction("SpawnMinigunTruck")
        task.wait(0.5)
        task.spawn(function()
            PerformAction("sTimer")
        end)
        PerformAction("newFarming")
    end)
end

gacorSay()
else
    print("manahwidluanjing")
end
