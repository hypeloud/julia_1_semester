#= 9. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении, на всем поле расставлены
маркеры в шахматном порядке, причем так, чтобы в клетке с роботом находился
маркер =#

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

x::Int = y::Int = 0
state::Bool = true

function is_putmarker!(robot, size)
    if (ismarker(robot)) return false end
    global x, state
    x_chess = Int(floor(x / size))
    if ((state && x_chess % 2 == 0) || (!state && x_chess % 2 == 1)) return true end
    return false
end

function move_putmarker_with_coords!(robot, side, size::Int)
    global x, y, state
    if (side == West) x -= 1
    elseif (side == Nord) y += 1
    elseif (side == Ost) x += 1
    elseif (side == Sud) y -= 1
    end
    move!(robot, side)
    y_chess = Int(floor(y / size))
    if ((!state && y_chess % 2 == 0) || (state && y_chess % 2 == 1)) state = !state end
    if (is_putmarker!(robot, size)) putmarker!(robot) end
end

function putmarker_line_with_coords!(robot, side, size::Int)
    while !isborder(robot, side)
        move_putmarker_with_coords!(robot, side, size)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot, n::Int)
    steps_count_Sud, steps_count_West = move_to_Sud_West!(robot)
    global state
    state = (steps_count_Sud % n == 0) ? true : false
    side = Ost
    if (is_putmarker!(robot, n)) putmarker!(robot) end
    putmarker_line_with_coords!(robot, side, n)
    while !isborder(robot, Nord)
        move_putmarker_with_coords!(robot, Nord, n)
        side = inverse(side)
        putmarker_line_with_coords!(robot, side, n)
    end
    move_to_Sud_West!(robot)
    move!(robot, Ost, steps_count_West)
    move!(robot, Nord, steps_count_Sud)
end

r = Robot("start_locations\\9.sit", animate=true)
start_proccess!(r, 1)