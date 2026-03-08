local Engine = {}

local loops = {}

function Engine:AddLoop(name, delay, func)

    if loops[name] then
        return
    end

    loops[name] = true

    task.spawn(function()

        while loops[name] do

            local success,err = pcall(func)

            if not success then
                warn("Genesis Engine Error:",err)
            end

            task.wait(delay)

        end

    end)

end


function Engine:RemoveLoop(name)

    loops[name] = nil

end


function Engine:StopAll()

    for k in pairs(loops) do
        loops[k] = nil
    end

end


return Engine
