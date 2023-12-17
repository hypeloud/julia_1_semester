#= 6. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного
поля, на котором могут находиться также внутренние прямоугольные
перегородки (все перегородки изолированы друг от друга, прямоугольники
могут вырождаться в отрезки)
РЕЗУЛЬТАТ: Робот - в исходном положении и -
a) по всему периметру внешней рамки стоят маркеры;
б) маркеры не во всех клетках периметра, а только в 4-х позициях -
напротив исходного положения робота. =#

using HorizonSideRobots

function move_to_Sud_West!(robot)
    move_sides = []
    move_offsets = [0, 0, 0, 0]
    while !isborder(robot, Sud) || !isborder(robot, West)
        for side in (Sud, West)
            if (!isborder(robot, side))
                move!(robot, side)
                push!(move_sides, side)
                move_offsets[Int(inverse(side))+1] += 1
            end
        end
    end
    return reverse(move_sides), move_offsets
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function start_proccess!(robot)
    move_sides, move_offsets = move_to_Sud_West!(robot)
    for side in (Nord, Ost, Sud, West)
        steps_count::Int = 0
        add_additional_steps_offset = false
        while !isborder(robot, side)
            move!(robot, side)
            steps_count += 1
            if (!add_additional_steps_offset && steps_count == move_offsets[Int(side)+1])
                putmarker!(robot)
                steps_count = 0
                add_additional_steps_offset = true
            end
        end
        if (add_additional_steps_offset) move_offsets[Int(inverse(side))+1] = steps_count end
    end
    for side in move_sides
        move!(robot, inverse(side))
    end
end

r = Robot("start_locations\\6.sit", animate=true)
start_proccess!(r)