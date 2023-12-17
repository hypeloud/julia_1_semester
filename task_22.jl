#= 22. Написать рекурсивную функцию, перемещающую робота на расстояние
вдвое большее исходного расстояния от перегородки, находящейся с заданного
направления (предполагается, что размеры поля позволяют это сделать).
Доработать эту функцию таким образом, чтобы она возвращала значение
true, в случае, если размеры поля позволяют удвоить расстояние, или - значение
false, в противном случае (в этом случае робот должен быть перемещен на
максимально возможное расстояние). =#

include("include\\librobot.jl")

function move_recursion_double_distance!(robot, side)
    if isborder(robot, side) return end
    move!(robot, side)
    move_recursion_double_distance!(robot, side)
    result::Bool = true
    if !try_move!(r, inverse(side)) result = false end
    if !try_move!(r, inverse(side)) result = false end
    return result
end

function start_proccess!(robot)
    result::Bool = move_recursion_double_distance!(robot, Nord)
    print(result)
end

r = Robot("start_locations\\22.sit", animate=true)
result::Bool = move_recursion_double_distance!(r, Nord)
print(result)