#= 3. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля
промаркированы. =#

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

function mark_line!(robot, side)
    while !isborder(robot, side) 
        move!(robot, side)
        putmarker!(robot)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot)
    steps_count_Sud, steps_count_West = move_to_Sud_West!(robot)
    side = Ost
    putmarker!(robot)
    mark_line!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        putmarker!(robot)
        side = inverse(side)
        mark_line!(robot, side)
    end
    move_to_Sud_West!(robot)
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud)
end

r = Robot("start_locations\\3.sit", animate=true)
start_proccess!(r)