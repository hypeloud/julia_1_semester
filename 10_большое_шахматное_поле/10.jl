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

function putmarker_with_row_type!(robot, row_type, steps_count::Int, size::Int)
    steps_count = Int(floor(steps_count / size))
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

function mark_line!(robot, side, row_type, size::Int)
    steps_count::Int = 0
    while !isborder(robot, side)
        putmarker_with_row_type!(robot, row_type, steps_count, size)
        move!(robot, side)
        steps_count += 1
    end
    return putmarker_with_row_type!(robot, row_type, steps_count, size)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot, n::Int)
    steps_count_Sud, steps_count_West = move_to_Sud_West!(robot)
    side = Ost
    row_type = true
    count_for_size = 1
    result = mark_line!(robot, side, row_type, n)
    if (count_for_size == n)
        row_type = !result
        count_for_size = 0
    else
        row_type = result
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        side = inverse(side)
        result = mark_line!(robot, side, row_type, n)
        count_for_size += 1
        if (count_for_size == n)
            row_type = !result
            count_for_size = 0
        else
            row_type = result
        end
    end
    move_to_Sud_West!(robot)
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud)
end

r = Robot("start_locations\\10.sit", animate=true)
start_proccess!(r, 3)