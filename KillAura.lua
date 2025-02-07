local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoids = game.Workspace:GetChildren()

-- Criando uma parte invisível ao redor do jogador (barreira)
local barrier = Instance.new("Part")
barrier.Size = Vector3.new(10, 10, 10)
barrier.Position = char.HumanoidRootPart.Position
barrier.Anchored = true
barrier.CanCollide = true
barrier.Transparency = 1
barrier.Parent = game.Workspace

-- Função para alterar a vida dos NPCs próximos
function setNPCsHealthToOne()
    for _, obj in ipairs(game.Workspace:GetChildren()) do
        -- Verifica se o objeto é um humanoide (NPC)
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local humanoid = obj.Humanoid
            humanoid.Health = 1 -- Define a vida do NPC para 1
        end
    end
end

-- Função para repelir NPCs
function repelNPCs()
    while true do
        wait(0.1) -- Checa a cada 0.1 segundos
        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                local humanoid = obj.Humanoid
                local npcPosition = obj.PrimaryPart.Position
                local distance = (npcPosition - barrier.Position).Magnitude

                -- Se o NPC estiver muito perto da barreira, empurre-o para longe
                if distance < 10 then
                    local direction = (npcPosition - barrier.Position).unit
                    humanoid:Move(Vector3.new(direction.X * 10, 0, direction.Z * 10)) -- Empurra o NPC para longe da barreira
                end
            end
        end
    end
end

-- Função para ativar ou desativar o Kill Aura
function toggleKillAura()
    killAuraEnabled = not killAuraEnabled

    if killAuraEnabled then
        setNPCsHealthToOne()  -- Modifica a vida dos NPCs para 1
        repelNPCs()           -- Começa a repelir os NPCs da barreira
    else
        -- Se desativar o Kill Aura, vamos parar de repelir os NPCs
        for _, obj in ipairs(game.Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                local humanoid = obj.Humanoid
                humanoid.Health = humanoid.MaxHealth -- Restaura a vida do NPC para o valor máximo
            end
        end
    end
end

-- Criando a interface do usuário com o botão "Kill Aura"
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 10, 0, 10)
button.Text = "Kill Aura: OFF"
button.Parent = screenGui

-- Função para quando o botão for clicado
button.MouseButton1Click:Connect(function()
    toggleKillAura()

    -- Atualiza o texto do botão para refletir o estado atual da Kill Aura
    if killAuraEnabled then
        button.Text = "Kill Aura: ON"
    else
        button.Text = "Kill Aura: OFF"
    end
end)
