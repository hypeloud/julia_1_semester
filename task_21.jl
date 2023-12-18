#= 21. Написать рекурсивную функцию, перемещающую робота в соседнюю
клетку в заданном направлении, при этом на пути робота может находиться
изолированная прямолинейная перегородка конечной длины. =#

include("include\\librobot.jl")

function move_recursion!(robot, side, n::Int = 0)
    left_side = left(side)
    if try_move!(robot, side)
        for i in 1:n move!(robot, inverse(left_side)) end
    else
        move!(robot, left_side)
        n += move_recursion!(robot, side, n+1)
    end
    return n
end

r = Robot("start_locations\\21.sit", animate=true)
move_recursion!(r, Nord)