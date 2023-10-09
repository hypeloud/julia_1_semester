using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Int)
    for k::Int in 1:num_steps
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function move_to_border_of_side!(robot, side)
    n::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function move_to_West_Sud!(robot)
    n_West = move_to_border_of_side!(robot, West)
    n_Sud = move_to_border_of_side!(robot, Sud)
    return n_West, n_Sud
end

function borders_count!(robot, side)
    already_counted = false
    borders_count::Int = passes_count::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        if isborder(robot, Nord)
            passes_count = 0
            already_counted = true
        elseif (already_counted)
            passes_count += 1
            if (isborder(robot, side) || passes_count >= 2) 
                borders_count += 1
                already_counted = false
            end
        end
    end
    return borders_count
end

function start_proccess!(robot)
    steps_count_West, steps_count_Sud = move_to_West_Sud!(robot)
    side = Ost
    all_borders_count::Int = 0
    while !isborder(robot, Nord)
        all_borders_count += borders_count!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end
    print(all_borders_count)
    move_to_West_Sud!(robot)
    move!(robot, Nord, steps_count_Sud)
    move!(robot, Ost, steps_count_West)
end

r = Robot("start_locations\\12.sit", animate=true)
start_proccess!(r)