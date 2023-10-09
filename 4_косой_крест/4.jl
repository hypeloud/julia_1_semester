using HorizonSideRobots

function HorizonSideRobots.move!(robot, side1, side2, num_steps::Int)
    for k in 1:num_steps
        move!(robot, side2)
        move!(robot, side1)
    end
end

function mark_line!(robot, side1, side2)
    n::Int = 0
    while !isborder(robot, side1) && !isborder(robot, side2)
        move!(robot, side1)
        move!(robot, side2)
        putmarker!(robot)
        n += 1
    end
    return n
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4)) 

function start_proccess!(robot)
    for side in ((Nord, West), (Nord, Ost), (Sud, Ost), (Sud, West))
        steps_count::Int = mark_line!(robot, side[1], side[2])
        move!(robot, inverse(side[1]), inverse(side[2]), steps_count)
    end
    putmarker!(robot)
end

r = Robot("start_locations\\4.sit", animate=true)
start_proccess!(r)