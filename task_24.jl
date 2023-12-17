#= 24. Написать рекурсивную функцию, перемещающую робота на расстояние
от перегородки с заданного направления вдвое меньшее исходного.
Указание: воспользоваться косвенной рекурсией. =#

include("include\\librobot.jl")

function move_processing!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        move_recursion!(robot, side) 
        move!(robot, inverse(side))
    end
end

move_recursion!(robot, side) = 
if !isborder(robot, side)
    move!(robot, side)
    move_processing!(robot,side)
end

r = Robot("start_locations\\24.sit", animate=true)
move_recursion!(r, Nord)