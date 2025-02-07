local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui") -- Garante que o PlayerGui carregue

-- Criando a interface com o botão "Kill Aura"
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui -- Corrigido para garantir que aparece na tela

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 0, 0, 200) -- Ajustado para ficar visível
button.Text = "Kill Aura: OFF"
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Vermelho para OFF
button.TextScaled = true
button.Visible = true -- Garante que o botão apareça
button.Parent = screenGui

-- Variável de status
local killAuraEnabled = false

-- Função para ativar/desativar a Kill Aura ao clicar no botão
button.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    button.Text = killAuraEnabled and "Kill Aura: ON" or "Kill Aura: OFF"
    button.BackgroundColor3 = killAuraEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0) -- Verde para ON, vermelho para OFF
end)
