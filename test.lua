local ErrorPrompt = getrenv().require(game.CoreGui.RobloxGui.Modules.ErrorPrompt)
local prompt = ErrorPrompt.new("Default")
prompt._hideErrorCode = true

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.OnTopOfCoreBlur = true

game:GetService("RunService"):SetRobloxGuiFocused(true)

prompt:setParent(gui)
prompt:setErrorTitle("Evolution")
prompt:updateButtons({{
   Text = "Okay",
   Callback = function() prompt:_close() 
       pcall(function()
           game:GetService("RunService"):SetRobloxGuiFocused(false)
       end)
   end,
   Primary = true
}}, 'Default')
prompt:_open("100% credits to xz#1111 (894608863289036881) now send me money $AlwysOnTop join .gg/serial for more leaks")

local bn = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
                if bn then
                    bn({
                        Url = 'http://127.0.0.1:6463/rpc?v=1',
                        Method = 'POST',
                        Headers = {
                            ['Content-Type'] = 'application/json',
                            Origin = 'https://discord.com'
                        },
                        Body = game:GetService("HttpService"):JSONEncode({
                            cmd = 'INVITE_BROWSER',
                            nonce = game:GetService("HttpService"):GenerateGUID(false),
                            args = {code = "h8scNf9wbr"}
                        })
                    })
                end
