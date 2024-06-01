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
    Name = "Infinite Jump",
    Callback = function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfiniteJumpEnabled then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)

        local InfiniteJump = CreateButton("Infinite Jump: On", StuffFrame)
        InfiniteJump.Position = UDim2.new(0, 10, 0, 130)
        InfiniteJump.Size = UDim2.new(0, 150, 0, 30)
        InfiniteJump.MouseButton1Click:Connect(function()
            local state = InfiniteJump.Text:sub(string.len("Infinite Jump: ") + 1) --too lazy to count lol
            local new = state == "Off" and "On" or state == "On" and "Off"
            InfiniteJumpEnabled = new == "On"
            InfiniteJump.Text = "Infinite Jump: " .. new
        end)
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
                if player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        local Line = Drawing.new("Line")
                        Line.Thickness = 2 -- Espessura da linha
                        Line.Color = Color3.fromRGB(0, 255, 0) -- Cor verde para o ESP
                        Line.Transparency = 1 -- Definido como transparente
                        Line.Visible = true -- Tornar a linha visível

                        game:GetService("RunService").Stepped:Connect(function()
                            if _G.espEnabled then
                                local pos, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(head.Position)
                                if onScreen then
                                    local distance = (head.Position - game:GetService("Workspace").CurrentCamera.CFrame.p).Magnitude
                                    local width = 1500 / (distance)
                                    Line.From = Vector2.new(game:GetService("Workspace").CurrentCamera.ViewportSize.X / 2, game:GetService("Workspace").CurrentCamera.ViewportSize.Y)
                                    Line.To = Vector2.new(pos.X, pos.Y)
                                    Line.Thickness = width -- Atualiza a espessura com base na distância
                                    Line.Transparency = 0.5 -- Define a transparência para a linha
                                else
                                    Line.Transparency = 1 -- Esconde a linha se o jogador não estiver visível na tela
                                end
                            else
                                Line.Transparency = 1 -- Esconde a linha quando o ESP está desativado
                            end
                        end)
                    end
                end
            end

            local function removeESP(player)
                if player.Character then
                    local line = player.Character:FindFirstChild("ESP_Line")
                    if line then
                        line:Remove()
                    end
                end
            end

            local function toggleESP(enabled)
                for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character then
                        if enabled then
                            createESP(player)
                        else
                            removeESP(player)
                        end
                    end
                end
            end

            game:GetService('Players').PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    if _G.espEnabled then
                        createESP(player)
                    end
                end)
            end)

            game:GetService('Players').PlayerRemoving:Connect(function(player)
                removeESP(player)
            end)

            toggleESP(_G.espEnabled)
        else
            toggleESP(_G.espEnabled)
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

local Button4 = MainTab:CreateButton({
    Name = "Ativar/Desativar Aimbot",
    Callback = function()
        _G.aimbotEnabled = not _G.aimbotEnabled

        if _G.aimbotStarted == nil then
            _G.aimbotStarted = true

            local function isEnemy(player)
                local myPlayer = game.Players.LocalPlayer
                if game.PlaceId == 286090429 then
                    return player.Team ~= myPlayer.Team -- Se estivermos em Arsenal, verificamos a equipe
                else
                    return true -- Para outros jogos, o Aimbot funcionará independentemente da equipe
                end
            end

            local camera = game.Workspace.CurrentCamera
            local players = game:GetService('Players')

            game:GetService('RunService').RenderStepped:Connect(function()
                if _G.aimbotEnabled then
                    local minDistance = math.huge
                    local target
                    local myPlayer = players.LocalPlayer
                    local myCharacter = myPlayer.Character
                    local myHead = myCharacter and myCharacter:FindFirstChild("Head")
                    if not myHead then return end
                    local myPosition = myHead.Position
                    for _, player in pairs(players:GetPlayers()) do
                        if player ~= myPlayer and player.Character and player.Character:FindFirstChild("Head") and isEnemy(player) then
                            local head = player.Character.Head
                            local headPosition = head.Position
                            local distance = (headPosition - myPosition).Magnitude
                            if distance < minDistance then
                                minDistance = distance
                                target = head
                            end
                        end
                    end

                    if target then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
                    end
                end
            end)
        end
    end,
})




