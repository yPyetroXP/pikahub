local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Notification",
        Content = "This is a notification",
        SubContent = "SubContent", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })

    Tabs.Main:AddParagraph({
        Title = "Paragraph",
        Content = "This is a paragraph.\nSecond line!"
    })

    Tabs.Main:AddButton({
        Title = "Button",
        Description = "Very important button",
        Callback = function()
            Window:Dialog({
                Title = "Title",
                Content = "This is a dialog",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            print("Confirmed the dialog.")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })

    -- Toggle for Aimbot
    local AimbotToggle = Tabs.Main:AddToggle("AimbotToggle", {Title = "Ativar/Desativar Aimbot LEGIT", Default = false })

    AimbotToggle:OnChanged(function()
        print("AimbotToggle changed:", Options.AimbotToggle.Value)
    end)

    Options.AimbotToggle:SetValue(false)

    -- Function to find the nearest target
    local function getNearestTarget()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = character.HumanoidRootPart
        local nearestTarget, nearestDistance = nil, math.huge
        
        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (target.Character.HumanoidRootPart.Position - rootPart.Position).magnitude
                if distance < nearestDistance then
                    nearestTarget = target
                    nearestDistance = distance
                end
            end
        end
        
        return nearestTarget
    end

    -- Aimbot logic
    local function aimAt(target)
        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = character.HumanoidRootPart
        local targetRootPart = target.Character.HumanoidRootPart
        
        rootPart.CFrame = CFrame.new(rootPart.Position, targetRootPart.Position)
    end

    -- Listen for right mouse button click
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if not processed and input.UserInputType == Enum.UserInputType.MouseButton2 and Options.AimbotToggle.Value then
            local target = getNearestTarget()
            aimAt(target)
        end
    end)
end

-- Addons:
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
