#= 1. ДАНО: Робот находится в произвольной клетке ограниченного
прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из
маркеров, расставленных вплоть до внешней рамки. =#

using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Int)
    for k::Int in 1:num_steps
        move!(robot, side)
    end
end

function mark_line!(robot, side)
    n::Int = 0
    while !isborder(robot, side) 
        move!(robot, side)
        putmarker!(robot)
        n += 1
    end
    return n
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot)
    for side in (Nord, West, Sud, Ost)
        steps_count = mark_line!(robot, side)
        move!(robot, inverse(side), steps_count)
    end
    putmarker!(robot)
end

r = Robot("start_locations\\1.sit", animate=true)
start_proccess!(r)