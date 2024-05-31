local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Obtendo o nome do jogo usando o serviço MarketplaceService
local NomeJogo = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name

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
       -- Alterna o estado do pulo infinito
       _G.infinjump = not _G.infinjump

       if _G.infinJumpStarted == nil then
           -- Garante que esta lógica seja executada apenas uma vez para economizar recursos
           _G.infinJumpStarted = true

           -- Notifica a prontidão
           game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Pulo Infinito ATIVADO!", Duration=5})

           -- A lógica do pulo infinito
           local plr = game:GetService('Players').LocalPlayer
           local m = plr:GetMouse()
           m.KeyDown:Connect(function(k)
               if _G.infinjump and k:byte() == 32 then -- 32 é o código ASCII para a barra de espaço
                   local humanoid = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
                   if humanoid then
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
       local player = game.Players.LocalPlayer
       local character = player and player.Character
       local humanoid = character and character:FindFirstChildOfClass("Humanoid")
       if humanoid then
           humanoid.WalkSpeed = Value
       end
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
       local player = game.Players.LocalPlayer
       local character = player and player.Character
       local humanoid = character and character:FindFirstChildOfClass("Humanoid")
       if humanoid then
           humanoid.JumpHeight = Value
       end
   end,
})

local Slider3 = MainTab:CreateSlider({
   Name = "Tamanho do Personagem",
   Range = {0.5, 5},
   Increment = 0.1,
   Suffix = "Tamanho",
   CurrentValue = 1,
   Flag = "sliderSize", 
   Callback = function(Value)
       local player = game.Players.LocalPlayer
       local character = player and player.Character
       if character then
           character:FindFirstChildOfClass("Humanoid").BodyScale.Value = Value
       end
   end,
})

local Dropdown = MainTab:CreateDropdown({
   Name = "Selecionar Área",
   Options = {"Mundo Inicial", "Ilha dos Piratas", "Paraíso dos Abacaxis"},
   CurrentOption = "Mundo Inicial",
   MultipleOptions = false,
   Flag = "dropdownarea", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
       local player = game.Players.LocalPlayer
       local character = player and player.Character
       if character then
           if Option == "Mundo Inicial" then
               character:SetPrimaryPartCFrame(CFrame.new(0, 100, 0))
           elseif Option == "Ilha dos Piratas" then
               character:SetPrimaryPartCFrame(CFrame.new(1000, 100, 0))
           elseif Option == "Paraíso dos Abacaxis" then
               character:SetPrimaryPartCFrame(CFrame.new(-1000, 100, 0))
           end
       end
   end,
})

local Button2 = MainTab:CreateButton({
   Name = "Ativar/Desativar Visibilidade Infinita",
   Callback = function()
       _G.infinvis = not _G.infinvis

       if _G.infinVisStarted == nil then
           _G.infinVisStarted = true
           game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Visibilidade Infinita ATIVADA!", Duration=5})

           local player = game:GetService('Players').LocalPlayer
           local character = player.Character
           while _G.infinvis do
               if character and character:FindFirstChildOfClass('Humanoid') then
                   character:FindFirstChildOfClass('Humanoid').Health = 100
               end
               wait(1)
           end
       end
   end,
})

local Button3 = MainTab:CreateButton({
    Name = "Ativar/Desativar ESP",
    Callback = function()
        _G.espEnabled = not _G.espEnabled

        if _G.espStarted == nil then
            _G.espStarted = true

            local function createESP(player)
                local Box = Instance.new("BoxHandleAdornment")
                Box.Name = "ESP"
                Box.Size = Vector3.new(4, 5, 1)
                Box.Color3 = Color3.fromRGB(255, 0, 0)
                Box.Transparency = 0.8
                Box.AlwaysOnTop = true
                Box.ZIndex = 10
                Box.Adornee = player.Character
                Box.Parent = player.Character
            end

            local function removeESP(player)
                if player.Character:FindFirstChild("ESP") then
                    player.Character:FindFirstChild("ESP"):Destroy()
                end
            end

            game:GetService('Players').PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    if _G.espEnabled then
                        createESP(player)
                    end
                end)
            end)

            for _, player in pairs(game:GetService('Players'):GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    if _G.espEnabled then
                        createESP(player)
                    else
                        removeESP(player)
                    end
                end
            end
        else
            for _, player in pairs(game:GetService('Players'):GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    if _G.espEnabled then
                        createESP(player)
                    else
                        removeESP(player)
                    end
                end
            end
        end
    end,
})

local Input = MainTab:CreateInput({
   Name = "Velocidade de Caminhada",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = true,
   Callback = function(Text)
       local speed = tonumber(Text)
       if speed then
           local player = game.Players.LocalPlayer
           local character = player and player.Character
           local humanoid = character and character:FindFirstChildOfClass("Humanoid")
           if humanoid then
               humanoid.WalkSpeed = speed
           end
       else
           print("Por favor, insira um número válido.")
       end
   end,
})
