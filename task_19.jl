#= 19. Написать рекурсивную функцию, перемещающую робота до упора в
заданном направлении. =#

include("include\\librobot.jl")

function move_recursion!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        move_recursion!(robot, side)
    end
end

r = Robot("start_locations\\19.sit", animate=true)
move_recursion!(r, Nord)