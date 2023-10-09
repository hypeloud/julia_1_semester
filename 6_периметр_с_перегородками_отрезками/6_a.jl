using HorizonSideRobots

function move_to_Sud_West!(robot)
    move_sides = []
    while !isborder(robot, Sud) || !isborder(robot, West)
        if !isborder(robot, Sud)
            move!(robot, Sud)
            push!(move_sides, Sud)
        end
        if !isborder(robot, West)
            move!(robot, West)
            push!(move_sides, West)
        end
    end
    return reverse(move_sides)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function start_proccess!(robot)
    move_sides = move_to_Sud_West!(robot)
    for side in (Nord, Ost, Sud, West)
        while !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end
    end
    for side in move_sides
        move!(robot, inverse(side))
    end
end

r = Robot("start_locations\\6.sit", animate=true)
start_proccess!(r)