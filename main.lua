local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local NomeJogo = game.Name

local Window = Rayfield:CreateWindow({
   Name = "🔥 Pika Hub | Jogo: " .. NomeJogo,
   LoadingTitle = "Pika Hub carregando...",
   LoadingSubtitle = "Feito por fxannn.exe",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Pika Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "XYVyF2fGae", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Chave | Pika Hub",
      Subtitle = "Sistema de Chave",
      Note = "Chave no Discord",
      FileName = "PikaHubKey1", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/AtgzSPWK"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Início", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Principal")

Rayfield:Notify({
   Title = "Bem-vindo!",
   Content = "Obrigado por usar meu script!",
   Duration = 5,
   Image = nil,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Ok!",
         Callback = function()
            print("O usuário apertou Ok!")
         end
      },
   },
})

local Button = MainTab:CreateButton({
   Name = "Ativar/Desativar Pulo Infinito",
   Callback = function()
       --Toggles the infinite jump between on or off on every script run
       _G.infinjump = not _G.infinjump

       if _G.infinJumpStarted == nil then
           --Ensures this only runs once to save resources
           _G.infinJumpStarted = true
           
           --Notifies readiness
           game.StarterGui:SetCore("SendNotification", {Title="Pika Hub"; Text="Pulo Infinito ATIVADO!"; Duration=5;})

           --The actual infinite jump
           local plr = game:GetService('Players').LocalPlayer
           local m = plr:GetMouse()
           m.KeyDown:connect(function(k)
               if _G.infinjump then
                   if k:byte() == 32 then
                       local humanoid = plr.Character:FindFirstChildOfClass('Humanoid')
                       humanoid:ChangeState('Jumping')
                       wait()
                       humanoid:ChangeState('Seated')
                   end
               end
           end)
       end
   end,
})

local Slider1 = MainTab:CreateSlider({
   Name = "Velocidade de Caminhada",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Velocidade",
   CurrentValue = 16,
   Flag = "sliderws", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local Slider2 = MainTab:CreateSlider({
   Name = "Poder de Salto",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Poder",
   CurrentValue = 50,
   Flag = "sliderjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

local Dropdown = MainTab:CreateDropdown({
   Name = "Selecionar Área",
   Options = {"Mundo Inicial", "Ilha dos Piratas", "Paraíso dos Abacaxis"},
   CurrentOption = "Mundo Inicial",
   MultipleOptions = false,
   Flag = "dropdownarea", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
       print(Option)
   end,
})

local Input = MainTab:CreateInput({
   Name = "Velocidade de Caminhada",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local speed = tonumber(Text)
       if speed then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
       else
           print("Por favor, insira um número válido.")
       end
   end,
})
