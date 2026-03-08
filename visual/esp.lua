local ESP = {}

function ESP:Add(obj)

    if obj:FindFirstChild("ESP") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP"
    highlight.FillColor = Color3.fromRGB(255,0,0)
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.Parent = obj

end

function ESP:EnableEnemies()

    for _,v in pairs(workspace.Enemies:GetChildren()) do
        ESP:Add(v)
    end

end

function ESP:EnableFruits()

    for _,v in pairs(workspace:GetChildren()) do

        if string.find(v.Name,"Fruit") then
            ESP:Add(v)
        end

    end

end

return ESP
