-- [[ GENESIS V50 - SUPER AUTO FARM MODULE ]]
local AutoFarm = {
    Enabled = false,
    TargetMob = "Monkey", -- Duy có thể làm thêm phần chọn quái sau
    Distance = 10
}

function AutoFarm:Init()
    _G.Genesis:Register("AutoFarm", self)
    
    spawn(function()
        while wait() do
            if self.Enabled then
                pcall(function()
                    local Mob = self:FindNearestMob()
                    if Mob and Mob:FindFirstChild("HumanoidRootPart") then
                        -- 1. Gom quái (Bring Mob) - Farm cực nhanh
                        self:BringMobs(Mob)
                        
                        -- 2. Bay đến quái (Tween)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 
                            Mob.HumanoidRootPart.CFrame * CFrame.new(0, self.Distance, 0)
                        
                        -- 3. Tự động bật Đánh nhanh
                        local Combat = _G.Genesis:Get("Combat")
                        if Combat then Combat.FastAttack = true end
                    end
                end)
            end
        end
    end)
end

function AutoFarm:FindNearestMob()
    local Target = nil
    local Distance = math.huge
    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local mag = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if mag < Distance then
                Distance = mag
                Target = v
            end
        end
    end
    return Target
end

function AutoFarm:BringMobs(Target)
    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Target.Name and v:FindFirstChild("HumanoidRootPart") then
            v.HumanoidRootPart.CFrame = Target.HumanoidRootPart.CFrame
            v.HumanoidRootPart.CanCollide = false
        end
    end
end

return AutoFarm
