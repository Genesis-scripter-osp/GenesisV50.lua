local FastAttack = {}

local vu = game:GetService("VirtualUser")

function FastAttack:Attack()

    vu:Button1Down(Vector2.new(0,0))
    task.wait()
    vu:Button1Up(Vector2.new(0,0))

end

function FastAttack:Start()

    while task.wait(0.1) do
        FastAttack:Attack()
    end

end

return FastAttack
