using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Int)
    for k::Int in 1:num_steps
        move!(robot, side)
    end
end

function move_to_border_of_side!(robot, side)
    n::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function start_proccess!(robot)
    steps_count_Sud = move_to_border_of_side!(robot, Sud)
    steps_count_West = move_to_border_of_side!(robot, West)
    for side in (Nord, Ost, Sud, West)
        while !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end
    end
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud)
end

r = Robot("start_locations\\2.sit", animate=true)
start_proccess!(r)