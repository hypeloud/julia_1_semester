using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Int, side_border)
    for k in 1:num_steps
        if !isborder(robot, side_border) return end
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot)
    side_border = nothing
    for side in (Nord, Ost, Sud, West)
        if isborder(robot, side)
            side_border = side
            break
        end
    end
    if (side_border == nothing) return end
    side_move = (side_border == Nord || side_border == Sud) ? Ost : Sud
    steps_count::Int = 0
    while isborder(robot, side_border)
        move!(robot, side_move, steps_count, side_border)
        move!(robot, inverse(side_move), steps_count*2, side_border)
        move!(robot, side_move, steps_count, side_border)
        steps_count += 1
    end
end

r = Robot("start_locations\\7.sit", animate=true)
start_proccess!(r)