#= 25. Написать рекурсивную функцию, перемещающую робота в заданном
направлении до упора и расставляющую маркеры в шахматном порядке,
a) начиная с установки маркера;
б) начиная без установки маркера (в стартовой клетке).
Указание: воспользоваться косвенной рекурсией =#

include("include\\librobot.jl")

function move_recursion_with_marker!(robot, side)
    putmarker!(robot)
    if !isborder(robot, side)
        move!(robot, side)
        move_recursion!(robot, side) 
    end
end

move_recursion!(robot, side) = 
if !isborder(robot, side)
    move!(robot, side)
    move_recursion_with_marker!(robot, side)
end

r = Robot("start_locations\\25.sit", animate=true)
move_recursion_with_marker!(r, Nord)