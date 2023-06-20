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
prompt:_open("100% credits to xz#1111 (894608863289036881) now send me money $AlwysOnTop")
