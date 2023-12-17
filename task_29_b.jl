#= 29. Написать функцию, расставляющие маркеры в каждой клетке внутри
произвольного замкнутого лабиринта, ограниченного
а) маркерами,
б) перегородками,
и возвращающую робота в исходное положение.
Указание: воспользоваться рекурсией. =#

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

r = Robot("start_locations\\29_b.sit", animate = true)
move_recursion!(r)