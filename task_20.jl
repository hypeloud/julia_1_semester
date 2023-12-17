#= 20. Написать рекурсивную функцию, перемещающую робота до упора в
заданном направлении, ставящую возле перегородки маркер и возвращающую
робота в исходное положение. =#

include("include\\librobot.jl")

function move_recursion_with_putmarker_near_border!(robot, side)
    if isborder(robot, side)
        putmarker!(robot)
        return 
    end
    move!(robot, side)
    move_recursion_with_putmarker_near_border!(robot, side)
    move!(robot, inverse(side))
end

r = Robot("start_locations\\20.sit", animate=true)
move_recursion_with_putmarker_near_border!(r, Nord)