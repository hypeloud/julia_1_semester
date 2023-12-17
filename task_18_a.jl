#= 18. Решить предыдущую задачу, но при дополнительном условии:
а) на поле имеются внутренние изолированные прямолинейные
перегородки конечной длины (только прямолинейных, прямоугольных
перегородок нет);
б) некоторые из прямолинейных перегородок могут быть
полубесконечными. =#

include("include\\librobot.jl")

function wall_recursion!(robot, side)
    if (isborder(robot, side))
        move!(robot, right(side))
        wall_recursion!(robot, side)
        move!(robot, inverse(right(side)))
    else
        move!(robot,side)
    end

end

function custom_along!(robot, side, n, stop_condition::Function)
    for i in 1:n
        if (!stop_condition()) wall_recursion!(robot, side) end
    end
end

function custom_spiral!(stop_condition::Function, robot)
    n::Int = 0
    side = Nord
    while !stop_condition()
        n += 1
        for i in 1:2
            custom_along!(robot, side, n, stop_condition)
            side = left(side)
        end
    end
end

function start_proccess!(robot)
    custom_spiral!(()->ismarker(robot), robot)
end

r = Robot("start_locations\\18_a.sit", animate=true)
start_proccess!(r)