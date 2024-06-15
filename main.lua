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


-- Definindo uma variável para armazenar o estado da interface (aberta ou fechada)
local interfaceOpen = false

-- Função para alternar a visibilidade da interface
local function toggleInterface()
    if interfaceOpen then
        Window:Hide() -- Esconder a interface
    else
        Window:Show() -- Mostrar a interface
    end
    interfaceOpen = not interfaceOpen
end

-- Criando um botão fora da interface principal para abrir a interface
local screenGui = Instance.new("ScreenGui")
local openButton = Instance.new("TextButton")

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "OpenInterfaceButtonGui"

openButton.Parent = screenGui
openButton.Size = UDim2.new(0, 100, 0, 50)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.new(1, 1, 1)
openButton.TextColor3 = Color3.new(0, 0, 0)
openButton.Text = "Abrir Interface"

openButton.MouseButton1Click:Connect(function()
    toggleInterface()
end)


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

local VisualTab = Window:CreateTab("👀 Visual", nil) -- Title, Image
local VisualSection = VisualTab:CreateSection("Funções de Visual")


local Button2 = VisualTab:CreateButton({
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

local Button3 = VisualTab:CreateButton({
    Name = "Ativar/Desativar ESP",
    Callback = function()
        _G.espEnabled = not _G.espEnabled

        if _G.espStarted == nil then
            _G.espStarted = true

            local function createESP(player)
                if player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        local Billboard = Instance.new("BillboardGui")
                        Billboard.Name = "ESP"
                        Billboard.Size = UDim2.new(2, 0, 2, 0) -- Tamanho do ESP
                        Billboard.StudsOffset = Vector3.new(0, 3, 0) -- Ajuste fino da altura em relação à cabeça do jogador
                        Billboard.Adornee = head
                        Billboard.AlwaysOnTop = true -- Garante que o ESP esteja sempre visível
                        Billboard.ExtentsOffset = Vector3.new(0, 0, 0) -- Deslocamento do centro do adorno para a borda da tela

                        local Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(1, 0, 1, 0)
                        Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Cor vermelha para o ESP
                        Frame.BackgroundTransparency = 0.5 -- Define a transparência do ESP
                        Frame.BorderSizePixel = 2
                        Frame.Parent = Billboard

                        Billboard.Parent = game.CoreGui
                    end
                end
            end

            local function removeESP(player)
                local billboard = player:FindFirstChild("ESP")
                if billboard then
                    billboard:Destroy()
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

local CombatTab = Window:CreateTab("☄ Combate", nil) -- Title, Image
local CombatSection = CombatTab:CreateSection("Funções de Combate")


local Button4 = CombatTab:CreateButton({
    Name = "Ativar/Desativar Aimbot",
    Callback = function()
        _G.aimbotEnabled = not _G.aimbotEnabled

        if _G.aimbotStarted == nil then
            _G.aimbotStarted = true

            local function isEnemy(player)
                local myPlayer = game.Players.LocalPlayer
                return player.Team ~= myPlayer.Team -- Independentemente do jogo, verificamos a equipe
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



local Button5 = CombatTab:CreateButton({
    Name = "Ativar/Desativar Rapid Fire",
    Callback = function()
        _G.rapidFireEnabled = not _G.rapidFireEnabled

        if _G.rapidFireEnabled then
            game:GetService("UserInputService").InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                    end
                end
            end)
        else
            game:GetService("UserInputService").InputBegan:Disconnect()
        end
    end,
})


-- Função para remover o recuo das armas
local function NoRecoil()
    local player = game.Players.LocalPlayer
    local camera = game.Workspace.CurrentCamera

    camera.Changed:Connect(function()
        if _G.noRecoilEnabled then
            -- Remove o recuo das armas ajustando o CFrame da câmera
            local recoilCorrection = CFrame.new(0, 0, 0)
            camera.CFrame = camera.CFrame * recoilCorrection
        end
    end)
end

local Button6 = CombatTab:CreateButton({
    Name = "Ativar/Desativar No Recoil",
    Callback = function()
        _G.noRecoilEnabled = not _G.noRecoilEnabled

        if _G.noRecoilEnabled then
            NoRecoil()
        end
    end,
})




local function SilentAim()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    local camera = game.Workspace.CurrentCamera
    
    mouse.Button1Down:Connect(function()
        if _G.silentAimEnabled then
            local target = FindNearestTarget()
            if target then
                local direction = (target.Position - camera.CFrame.Position).unit
                camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
            end
        end
    end)
end

local Button7 = CombatTab:CreateButton({
    Name = "Ativar/Desativar Silent Aim",
    Callback = function()
        _G.silentAimEnabled = not _G.silentAimEnabled

        if _G.silentAimEnabled then
            SilentAim()
        end
    end,
})

function FindNearestTarget()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local camera = game.Workspace.CurrentCamera

    if not humanoidRootPart then
        return
    end

    local nearestTarget = nil
    local shortestDistance = math.huge

    for _, targetPlayer in ipairs(game.Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character then
            local targetCharacter = targetPlayer.Character
            local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetHumanoidRootPart then
                local distance = (targetHumanoidRootPart.Position - humanoidRootPart.Position).magnitude
                local onScreen, screenPos = camera:WorldToScreenPoint(targetHumanoidRootPart.Position)
                if onScreen then
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestTarget = targetHumanoidRootPart
                    end
                end
            end
        end
    end

    return nearestTarget
end





function PredictMovement(targetPosition, targetVelocity, targetDistance)
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local camera = game.Workspace.CurrentCamera
    
    if not humanoidRootPart then
        return
    end

    local myPosition = humanoidRootPart.Position
    local myVelocity = (myPosition - humanoidRootPart.Position)
    local gravity = Vector3.new(0, -15, 0) -- Ajuste a gravidade de acordo com o jogo (valor negativo para gravidade para baixo)
    local targetGravity = targetVelocity.Y * gravity

    -- Calcular o tempo para atingir o alvo horizontalmente
    local timeToHit = targetDistance / myVelocity.Magnitude

    -- Prever a posição horizontal do alvo
    local predictedHorizontalTargetPosition = targetPosition + targetVelocity * timeToHit

    -- Prever a posição vertical do alvo considerando a gravidade
    local predictedVerticalTargetPosition = predictedHorizontalTargetPosition + targetGravity * 0.5 * timeToHit^2

    -- Orientar a câmera para o ponto predito
    camera.CFrame = CFrame.new(camera.CFrame.Position, predictedVerticalTargetPosition)
end

local function UpdatePrediction()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    local camera = game.Workspace.CurrentCamera
    local target = FindNearestTarget()

    if target then
        local targetPosition = target.Position
        local targetVelocity = target.Velocity
        local targetDistance = (targetPosition - camera.CFrame.Position).Magnitude
        PredictMovement(targetPosition, targetVelocity, targetDistance)
    end
end

local function PredictiveAim()
    while true do
        if _G.predictiveAimEnabled then
            UpdatePrediction()
        end
        wait(0.1) -- Ajuste o intervalo conforme necessário para equilibrar a precisão e o desempenho
    end
end

local Button9 = CombatTab:CreateButton({
    Name = "Ativar/Desativar Predição de Movimento",
    Callback = function()
        _G.predictiveAimEnabled = not _G.predictiveAimEnabled

        if _G.predictiveAimEnabled then
            coroutine.wrap(PredictiveAim)()
        end
    end,
})

local function TeleportToNearestPlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    local nearestPlayer = FindNearestPlayer()

    if nearestPlayer and humanoidRootPart then
        local targetCharacter = nearestPlayer.Character
        local targetHumanoidRootPart = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
        
        if targetHumanoidRootPart then
            humanoidRootPart.CFrame = targetHumanoidRootPart.CFrame * CFrame.new(0, 5, 0) -- Teleporta o jogador local para cima do jogador mais próximo
        end
    end
end

local function FindNearestPlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return
    end

    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local targetCharacter = otherPlayer.Character
            local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetHumanoidRootPart then
                local distance = (targetHumanoidRootPart.Position - humanoidRootPart.Position).magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestPlayer = otherPlayer
                end
            end
        end
    end

    return nearestPlayer
end

local Button10 = CombatTab:CreateButton({
    Name = "Teleportar para Jogador Mais Próximo",
    Callback = function()
        TeleportToNearestPlayer()
    end,
})



--> VARIABLES <--
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = game:GetService("Workspace").CurrentCamera

--> FUNCTIONS <--
function notBehindWall(target)
    local ray = Ray.new(plr.Character.Head.Position, (target.Position - plr.Character.Head.Position).Unit * 300)
    local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {plr.Character}, false, true)
    if part then
        local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and target and humanoid.Parent == target.Parent then
            local pos, visible = camera:WorldToScreenPoint(target.Position)
            if visible then
                return true
            end
        end
    end
end

function getPlayerClosestToMouse()
    local target = nil
    local maxDist = 100
    for _,v in pairs(plrs:GetPlayers()) do
        if v.Character then
            if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= plr.TeamColor then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).magnitude
                if dist < maxDist and vis then
                    local torsoPos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    local torsoDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(torsoPos.X, torsoPos.Y)).magnitude
                    local headPos = camera:WorldToViewportPoint(v.Character.Head.Position)
                    local headDist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(headPos.X, headPos.Y)).magnitude
                    if torsoDist > headDist then
                        if notBehindWall(v.Character.Head) then
                            target = v.Character.Head
                        end
                    else
                        if notBehindWall(v.Character.HumanoidRootPart) then
                            target = v.Character.HumanoidRootPart
                        end
                    end
                    maxDist = dist
                end
            end
        end
    end
    return target
end

--> Hooking to the remote <--
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "HitPart" and tostring(method) == "FireServer" then
        Args[1] = getPlayerClosestToMouse()
        Args[2] = getPlayerClosestToMouse().Position
        return self.FireServer(self, unpack(Args))
    end
    return oldNamecall(self, ...)
end)

local Button11 = CombatTab:CreateButton({
    Name = "Ativar/Desativar Aim Assist",
    Callback = function()
        _G.aimAssistEnabled = not _G.aimAssistEnabled

        if _G.aimAssistEnabled then
            -- Código para ativar o Aim Assist (já implementado acima)
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Aim Assist ATIVADO!", Duration=5})
        else
            -- Código para desativar o Aim Assist (caso necessário)
            game.StarterGui:SetCore("SendNotification", {Title="Pika Hub", Text="Aim Assist DESATIVADO!", Duration=5})
        end
    end,
})


local function AcharPlayerProximo()
  local nearestPlayer = nil
  local nearestDistance = math.huge

  local players = game.Players:GetPlayers() -- Get all players as a table

  for _, player in ipairs(players) do  -- Iterate using ipairs
    if player ~= game.Players.LocalPlayer then
      local localRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
      local targetRootPart = player.Character.HumanoidRootPart

      local distance = (localRootPart.Position - targetRootPart.Position).Magnitude

      if distance < nearestDistance then
        nearestPlayer = player
        nearestDistance = distance
      end
    end
  end

  return nearestPlayer
end


local function FlyToNearestPlayer()
    local targetPlayer = FindNearestPlayer()
    if targetPlayer then
        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
        local player = game.Players.LocalPlayer
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, targetPosition)

        -- ... (Adicionar efeito visual opcional)
    end
end

-- Criar o botão
local FlyToNearestPlayerButton = MainTab:CreateButton({
    Name = "Voar para Jogador Próximo",
    Callback = FlyToNearestPlayer,
})


local Button14 = CombatTab:CreateButton({
    Name = "Ativar/Desativar BHOP",
    Callback = function()
        _G.bhopEnabled = not _G.bhopEnabled

        if _G.bhopStarted == nil then
            _G.bhopStarted = true

            game:GetService('RunService').RenderStepped:Connect(function()
                if _G.bhopEnabled then
                    local myPlayer = game.Players.LocalPlayer
                    local myCharacter = myPlayer.Character
                    local humanoid = myCharacter and myCharacter:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Running then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end,
})

local FarmTab = Window:CreateTab("🌾 Auto Farm", nil) -- Title, Image
local FarmSection = FarmTab:CreateSection("Funções de Auto Farm")

local AutoFarmEnabled = false

-- Função para encontrar a fruta mais próxima
local function FindNearestFruit()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return nil
    end

    local nearestFruit = nil
    local shortestDistance = math.huge

    for _, fruit in ipairs(game.Workspace:GetChildren()) do
        if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            local distance = (fruit.Handle.Position - humanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestFruit = fruit
            end
        end
    end

    return nearestFruit
end

-- Função para encontrar o inimigo mais próximo
local function FindNearestEnemy()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return nil
    end

    local nearestEnemy = nil
    local shortestDistance = math.huge

    for _, enemy in ipairs(game.Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            local distance = (enemy.HumanoidRootPart.Position - humanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestEnemy = enemy
            end
        end
    end

    return nearestEnemy
end

-- Função de Auto Farm
local function AutoFarm()
    while AutoFarmEnabled do
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            -- Tentar pegar a fruta mais próxima
            local nearestFruit = FindNearestFruit()
            if nearestFruit then
                humanoidRootPart.CFrame = nearestFruit.Handle.CFrame
                wait(1) -- Tempo para coletar a fruta
                nearestFruit.Parent = player.Backpack
            end

            -- Tentar derrotar o inimigo mais próximo
            local nearestEnemy = FindNearestEnemy()
            if nearestEnemy then
                humanoidRootPart.CFrame = nearestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) -- Aproximar-se do inimigo
                -- Simular ataque (ajuste conforme necessário para seu jogo)
                game:GetService("ReplicatedStorage").Events.AttackEvent:FireServer(nearestEnemy)
                wait(1) -- Tempo entre ataques
            end
        end

        wait(0.5) -- Intervalo entre cada loop
    end
end

-- Criar o botão para ativar/desativar o Auto Farm
local AutoFarmButton = FarmTab:CreateButton({
    Name = "Ativar/Desativar Auto Farm",
    Callback = function()
        AutoFarmEnabled = not AutoFarmEnabled

        if AutoFarmEnabled then
            coroutine.wrap(AutoFarm)()
            Rayfield:Notify({
                Title = "Auto Farm",
                Content = "Auto Farm ativado!",
                Duration = 5,
                Image = nil,
                Actions = { -- Notification Buttons
                    Ignore = {
                        Name = "Ok!",
                        Callback = function()
                            print("Usuário reconheceu a notificação.")
                        end
                    },
                },
            })
        else
            Rayfield:Notify({
                Title = "Auto Farm",
                Content = "Auto Farm desativado!",
                Duration = 5,
                Image = nil,
                Actions = { -- Notification Buttons
                    Ignore = {
                        Name = "Ok!",
                        Callback = function()
                            print("Usuário reconheceu a notificação.")
                        end
                    },
                },
            })
        end
    end,
})
