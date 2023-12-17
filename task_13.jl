#= 13. Решить задачу 9 с использованием обобщённой функции
snake!(robot,
(move_side, next_row_side)::NTuple{2,HorizonSide} =
(Ost,Nord)) =#

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

function start_proccess!(robot)
    steps_count_West, steps_count_Sud = move_to_West_Sud!(robot)
    putmarker!(robot)
    chess_robot = ChessRobotN(robot, 1)
    snake!(chess_robot; start_side=Ost, ortogonal_side=Nord)
    move_to_West_Sud!(robot)
    move!(robot, Nord, steps_count_Sud)
    move!(robot, Ost, steps_count_West)
end

r = Robot("start_locations\\13.sit", animate=true)
start_proccess!(r)