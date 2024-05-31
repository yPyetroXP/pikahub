local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 Pika Hub | Versão 1.0",
    LoadingTitle = "Universal Script",
    LoadingSubtitle = "feito por Lawzera (fxannn.exe)",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Pika Hub V1"
    },
    Discord = {
       Enabled = true,
       Invite = "XYVyF2fGae", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Pika Hub | Key System",
       Subtitle = "Sistema de Key do Script",
       Note = "Pegue a key no nosso Discord!",
       FileName = "pikahubkey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"release"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

local MainTab = Window:CreateTab("🏠 Aba Inicial", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Inicio")

local Button = MainTab:CreateButton({
    Name = "Ativar Pulo Infinito",
    Callback = function()
        --Toggles the infinite jump between on or off on every script run
 _G.infinjump = not _G.infinjump
 
 if _G.infinJumpStarted == nil then
     --Ensures this only runs once to save resources
     _G.infinJumpStarted = true
     
     --Notifies readiness
     game.StarterGui:SetCore("SendNotification", {Title="Pika Hub"; Text="Pulo Infinito ativado!"; Duration=5;})
 
     --The actual infinite jump
     local plr = game:GetService('Players').LocalPlayer
     local m = plr:GetMouse()
     m.KeyDown:connect(function(k)
         if _G.infinjump then
             if k:byte() == 32 then
             humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
             humanoid:ChangeState('Jumping')
             wait()
             humanoid:ChangeState('Seated')
             end
         end
     end)
 end
    end,
 })
 
