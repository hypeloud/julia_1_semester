using HorizonSideRobots

function move_to_border_of_side!(robot, side)
    n::Int = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end

function move_to_Sud_West!(robot)
    n_Sud1 = move_to_border_of_side!(robot, Sud)
    n_West = move_to_border_of_side!(robot, West)
    n_Sud2 = move_to_border_of_side!(robot, Sud)
    return n_Sud1, n_West, n_Sud2
end

function find_in_line!(robot, side)
    while !isborder(robot, Nord) && !isborder(robot, side)
        move!(robot, side)
    end
    return isborder(robot, Nord)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function find_border!(robot)
    side = Ost
    while !find_in_line!(robot, side)
        move!(robot, Nord)
        side = inverse(side)
    end
    return side
end

function check_side(side)
    if side == West || side == Ost return (Nord, Sud)
    else return (West, Ost)
    end
end

function move_with_putmarker!(robot, side)
    move!(robot, side)
    putmarker!(robot)
end

function HorizonSideRobots.move!(robot, side, num_steps::Int)
    for k::Int in 1:num_steps
        move!(robot, side)
    end
end

function start_proccess!(robot)
    steps_count_Sud_1, steps_count_West, steps_count_Sud_2 = move_to_Sud_West!(robot)
    for side in (Nord, Ost, Sud, West)
        while !isborder(robot, side)
            move_with_putmarker!(robot, side)
        end
    end
    result_side = find_border!(robot)
    putmarker!(robot)
    sides = (result_side == Ost) ? [Ost, Nord, West, Sud] : [West, Nord, Ost, Sud]
    for side in sides
        move_with_putmarker!(robot, side)
        sides = check_side(side)
        while isborder(robot, sides[1]) || isborder(robot, sides[2])
            move_with_putmarker!(robot, side)
        end
    end
    move_to_Sud_West!(robot)
    move!(robot, Nord, steps_count_Sud_2)
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud_1)
end

r = Robot("start_locations\\5.sit", animate=true)
start_proccess!(r)