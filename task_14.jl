#= 14. Решить предыдущую задачу, но при условии наличия на поле простых
внутренних перегородок.
Под простыми перегородками мы понимаем изолированные
прямолинейные или прямоугольные перегородки =#

include("include\\chessrobot.jl")

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

function move(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
    end
end

function try_move!(robot::ChessRobotN, side)
    ortogonal_side = left(side)
    back_side = inverse(ortogonal_side)
    n = 0
    while isborder(robot, side) == true && isborder(robot, ortogonal_side) == false
        move!(robot::ChessRobotN, ortogonal_side)
        n += 1
    end
    if isborder(robot, side) == true
        move!(robot::ChessRobotN, back_side, n)
        return false
    end
    move!(robot, side)
    if n > 0
        along!(()->!isborder(robot, back_side), robot, side) 
        move!(robot::ChessRobotN, back_side, n)
    end
    return true
end

function snake(robot)
    side = Ost
    fix::Bool = true
    while !isborder(robot, Nord) || !isborder(robot, West) || fix
        if isborder(robot, Nord) && isborder(robot, West) fix = false end
        while try_move!(robot, side) end
        move(robot, Nord)
        while try_move!(robot, inverse(side)) end
        move(robot, Nord)
    end
end

function start_proccess!(robot)
    steps_count_West, steps_count_Sud = move_to_West_Sud!(robot)
    putmarker!(robot)
    chess_robot = ChessRobotN(robot, 1)
    snake(chess_robot)
    move_to_West_Sud!(robot)
    move!(robot, Nord, steps_count_Sud)
    move!(robot, Ost, steps_count_West)
end

r = Robot("start_locations\\14.sit", animate=true)
start_proccess!(r)