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
                local Billboard = Instance.new("BillboardGui")
                Billboard.Name = "ESP"
                Billboard.AlwaysOnTop = true
                Billboard.Size = UDim2.new(4, 0, 5, 0)
                Billboard.StudsOffset = Vector3.new(0, 3, 0)
                Billboard.Adornee = player.Character.Head

                local Frame = Instance.new("Frame")
                Frame.BackgroundTransparency = 0.5
                Frame.Size = UDim2.new(1, 0, 1, 0)
                Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                Frame.BorderSizePixel = 0
                Frame.Parent = Billboard

                Billboard.Parent = game.CoreGui
            end

            local function removeESP(player)
                local billboard = player.Character:FindFirstChild("ESP")
                if billboard then
                    billboard:Destroy()
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

            for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    if _G.espEnabled then
                        createESP(player)
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

local Button4 = MainTab:CreateButton({
    Name = "Ativar/Desativar Aimbot",
    Callback = function()
        _G.aimbotEnabled = not _G.aimbotEnabled

        if _G.aimbotStarted == nil then
            _G.aimbotStarted = true

            local gameId = tostring(game.PlaceId)
            if gameId == "286090429" then
                Rayfield:Notify({
                    Title = "Aimbot Indisponível",
                    Content = "O aimbot não está disponível neste jogo.",
                    Duration = 5,
                })
                return
            end

            local camera = game.Workspace.CurrentCamera
            local players = game:GetService('Players')

            game:GetService('RunService').RenderStepped:Connect(function()
                if _G.aimbotEnabled then
                    local target
                    local maxDotProduct = -math.huge
                    local myPlayer = players.LocalPlayer
                    local myCharacter = myPlayer.Character
                    local myHead = myCharacter and myCharacter:FindFirstChild("Head")
                    if not myHead then return end
                    local myPosition = myHead.Position
                    for _, player in pairs(players:GetPlayers()) do
                        if player ~= myPlayer and player.Character and player.Character:FindFirstChild("Head") then
                            local head = player.Character.Head
                            local headPosition = head.Position
                            local directionToHead = (headPosition - myPosition).unit
                            local cameraDirection = (headPosition - camera.CFrame.Position).unit
                            local dotProduct = directionToHead:Dot(cameraDirection)
                            if dotProduct > maxDotProduct then
                                -- Verifica se há obstrução entre o jogador local e o jogador inimigo
                                local ray = Ray.new(camera.CFrame.Position, headPosition - camera.CFrame.Position)
                                local part, position = workspace:FindPartOnRay(ray, myCharacter, false, true)
                                if part and part:IsDescendantOf(player.Character) then
                                    maxDotProduct = dotProduct
                                    target = head
                                end
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

local function FireFreeShot()
    local myPlayer = game:GetService('Players').LocalPlayer
    local camera = game.Workspace.CurrentCamera

    local closestEnemy
    local minDistance = math.huge

    for _, player in pairs(game:GetService('Players'):GetPlayers()) do
        if player ~= myPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local distance = (head.Position - camera.CFrame.Position).magnitude
            if distance < minDistance then
                closestEnemy = head
                minDistance = distance
            end
        end
    end

    if closestEnemy then
        -- Disparar
        -- Substitua essa parte com sua lógica de disparo real
        print("Disparando em " .. closestEnemy.Parent.Name)
    else
        print("Nenhum inimigo encontrado.")
    end
end

-- Função para ativar/desativar o "Tiro Livre"
local Button6 = MainTab:CreateButton({
    Name = "Ativar/Desativar Tiro Livre",
    Callback = function()
        _G.freeShotEnabled = not _G.freeShotEnabled

        if _G.freeShotEnabled then
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Tiro Livre ATIVADO!", Duration=5})
        else
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Tiro Livre DESATIVADO!", Duration=5})
        end
    end,
})

-- Tiro Livre Loop
game:GetService('RunService').Stepped:Connect(function()
    if _G.freeShotEnabled then
        FireFreeShot()
    end
end)



local function IsEnemy(player)
    local myPlayer = game:GetService('Players').LocalPlayer
    if player.Team ~= myPlayer.Team then
        return true -- Se os jogadores estiverem em equipes diferentes, consideramos este jogador um inimigo
    end
    return false
end

-- Agora, vamos integrar a função IsEnemy no código do triggerbot:

-- Triggerbot Loop
game:GetService('RunService').RenderStepped:Connect(function()
    if _G.triggerbotEnabled then
        local camera = game.Workspace.CurrentCamera
        local myPlayer = game:GetService('Players').LocalPlayer

        for _, player in pairs(game:GetService('Players'):GetPlayers()) do
            if player ~= myPlayer and IsEnemy(player) then
                local head = player.Character and player.Character:FindFirstChild("Head")
                if head then
                    local direction = (head.Position - camera.CFrame.Position).unit
                    local ray = Ray.new(camera.CFrame.Position, direction * 300)
                    local part, position = workspace:FindPartOnRay(ray, myPlayer.Character, false, true)
                    if part and part:IsDescendantOf(player.Character) then
                        -- Disparar
                        -- Substitua essa parte com sua lógica de disparo real
                        print("Disparando no jogador: " .. player.Name)
                    end
                end
            end
        end
    end
end)



-- Função para ativar/desativar o triggerbot
local Button5 = MainTab:CreateButton({
    Name = "Ativar/Desativar Triggerbot",
    Callback = function()
        _G.triggerbotEnabled = not _G.triggerbotEnabled

        if _G.triggerbotEnabled then
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Triggerbot ATIVADO!", Duration=5})
        else
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Triggerbot DESATIVADO!", Duration=5})
        end
    end,
})


