-- Made by Vincent2323 and xz#1111
-- .gg/serial



--_G.WebHook = ""

repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("FULLY_LOADED_CHAR")
wait(1)
local scriptloadstring = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/laagginq/misc-scripts/main/da-hood-autofarm.lua"))()]]
if not isfolder("dahoodautofarm") then 
    makefolder("dahoodautofarm")
end
if _G.WebHook then 
    writefile("dahoodautofarm/webhook.txt",_G.WebHook)
end

assert(getrawmetatable)
grm = getrawmetatable(game)
setreadonly(grm, false)
old = grm.__namecall
grm.__namecall =
    newcclosure(
    function(self, ...)
        local args = {...}
        if tostring(args[1]) == "TeleportDetect" then
            return
        elseif tostring(args[1]) == "CHECKER_1" then
            return
        elseif tostring(args[1]) == "CHECKER" then
            return
        elseif tostring(args[1]) == "GUI_CHECK" then
            return
        elseif tostring(args[1]) == "OneMoreTime" then
            return
        elseif tostring(args[1]) == "checkingSPEED" then
            return
        elseif tostring(args[1]) == "BANREMOTE" then
            return
        elseif tostring(args[1]) == "PERMAIDBAN" then
            return
        elseif tostring(args[1]) == "KICKREMOTE" then
            return
        elseif tostring(args[1]) == "BR_KICKPC" then
            return
        elseif tostring(args[1]) == "BR_KICKMOBILE" then
            return
        end
        return old(self, ...)
    end
)


local humanoid = game.Players.LocalPlayer.Character.Humanoid
local tool = game.Players.LocalPlayer.Backpack.Combat
local maxcashiers = 27

local oldcash = game.Players.LocalPlayer.DataFolder.Currency.Value
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

for i, v in ipairs(game.Workspace.Cashiers:GetChildren()) do
    maxcashiers = i
end

local function formatNumber(number)
    number = tostring(number)
    return number:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
 end

 local function getcashonflooramt() 
    local amount = 0
    for i,v in pairs(game:GetService("Workspace").Ignored.Drop:GetChildren()) do 
       if v.Name == "MoneyDrop" then 
          local value = ""
          value = tostring(v.BillboardGui.TextLabel.Text)
          value = value:gsub("[$,]", "")
          local newvalue = ""
          newvalue = tonumber(value)
          amount = amount + newvalue
       end    
    end
    return formatNumber(amount)
 end

local function sendwebhook(serverid,msg) 
    local OSTime = os.time()
    local Time = os.date("!*t", OSTime)
    local Content = ""
    local Embed = {
        ["title"] = "**"..game.Players.LocalPlayer.Name.." has server hopped**",
        ["type"] = "rich",
        ["fields"] = {
            {
                ["name"] = "Cash Made",
                ["value"] = "$"..formatNumber(game.Players.LocalPlayer.DataFolder.Currency.Value - oldcash),
                ["inline"] = false
            },
            {
                ["name"] = "Cash Missed",
                ["value"] = "$"..getcashonflooramt(),
                ["inline"] = false
            },
            {
                ["name"] = "Total Cash",
                ["value"] = "$"..formatNumber(game.Players.LocalPlayer.DataFolder.Currency.Value),
                ["inline"] = false
            },
            {
                ["name"] = "New Server ID",
                ["value"] = serverid,
                ["inline"] = false
            },
            {
                ["name"] = "Reason",
                ["value"] = msg,
                ["inline"] = false
            },
        },
        ["footer"] = {
            ["text"] = "Da Hood Auto Farm | .gg/serial | xz#1111",
        },
        ["timestamp"] = string.format(
            "%d-%d-%dT%02d:%02d:%02dZ",
            Time.year,
            Time.month,
            Time.day,
            Time.hour,
            Time.min,
            Time.sec
        )
    }
    (httprequest) {
        Url = readfile("dahoodautofarm/webhook.txt"),
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService "HttpService":JSONEncode({content = Content, embeds = {Embed}})
    }
end

local function ServerHop() 
    queue_on_teleport(scriptloadstring)
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"
    
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
       local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
       return Http:JSONDecode(Raw)
    end
    
    local Server, Next; repeat
       local Servers = ListServers(Next)
       Server = Servers.data[1]
       Next = Servers.nextPageCursor
    until Server
    sendwebhook(Server.id,"No More Open Cashiers")
    wait(1)
    TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end


local function startAutoFarm() 
    (httprequest) {
        Url = readfile("dahoodautofarm/webhook.txt"),
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService "HttpService":JSONEncode({content = "Auto Farm has started on "..game.Players.LocalPlayer.Name})
    }
    humanoid:EquipTool(tool)
    for i, v in ipairs(game.Workspace.Cashiers:GetChildren()) do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Open.CFrame * CFrame.new(0, 0, 2)
        print(tostring(i.."/"..maxcashiers))
        for i = 0, 15 do
            wait(0.5)
            tool:Activate()
        end
    end
    wait(0.5)
    print("Ended")
    ServerHop() 
end

local a1 = false

task.spawn(function()
    while wait() do 
        for i,v in pairs(game:GetService('Workspace')['Ignored']['Drop']:GetChildren()) do
            if v:IsA('Part') then
                if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 12 then
                    local success, err = pcall(function()
                        fireclickdetector(v:FindFirstChild('ClickDetector'))
                    end)
                    if success == false then 
                        if a1 == false then 
                            a1 = true
                            ServerHop()
                            sendwebhook(v.id,"Something broke :(")
                        end
                    end
                end
            end
        end
    end
end)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
        ServerHop()
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.R then 
        ServerHop()
    end
end)

delay(300,function()
    ServerHop()
    sendwebhook(v.id,"Timed Out")
end)

startAutoFarm()
