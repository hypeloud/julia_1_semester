#= 26. Написать функцию, маркирующую все клетки лабиринта произвольной
формы, ограниченного перегородками, и возвращающую робота в исходное
положение. =#

include("include\\librobot.jl")

move_recursion!(robot) = 
if !ismarker(robot)
    putmarker!(robot)
    for side in (Nord, West, Sud, Ost)
        if !isborder(robot, side)
            move!(robot, side)
            move_recursion!(robot)
            move!(robot, inverse(side))
        end 
    end
end

r = Robot("start_locations\\26.sit", animate=true)
move_recursion!(r)