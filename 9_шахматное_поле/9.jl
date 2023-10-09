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

function move_to_Sud_West!(robot)
    n_Sud = move_to_border_of_side!(robot, Sud)
    n_West = move_to_border_of_side!(robot, West)
    return n_Sud, n_West
end

function putmarker_with_row_type!(robot, row_type, steps_count::Int)
    if (row_type)
        if (steps_count % 2 == 0)
            putmarker!(robot)
            return true
        end
    elseif (steps_count % 2 != 0)
        putmarker!(robot)
        return true
    end
    return false
end

function mark_line!(robot, side, row_type)
    steps_count::Int = 0
    while !isborder(robot, side)
        putmarker_with_row_type!(robot, row_type, steps_count)
        move!(robot, side)
        steps_count += 1
    end
    return putmarker_with_row_type!(robot, row_type, steps_count)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot)
    steps_count_Sud, steps_count_West = move_to_Sud_West!(robot)
    is_steps_count_Sud_even_number = (steps_count_Sud % 2 == 0)
    is_steps_count_West_even_number = (steps_count_West % 2 == 0)
    side = Ost
    row_type = ((is_steps_count_Sud_even_number && is_steps_count_West_even_number) || (!is_steps_count_Sud_even_number && !is_steps_count_West_even_number))
    result = mark_line!(robot, side, row_type)
    row_type = !result
    while !isborder(robot, Nord)
        move!(robot, Nord)
        side = inverse(side)
        result = mark_line!(robot, side, row_type)
        row_type = !result
    end
    move_to_Sud_West!(robot)
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud)
end

r = Robot("start_locations\\9.sit", animate=true)
start_proccess!(r)