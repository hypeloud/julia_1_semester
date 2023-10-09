using HorizonSideRobots

function HorizonSideRobots.move!(robot, side, num_steps::Int)
    for k in 1:num_steps
        if ismarker(robot) return end
        move!(robot, side)
    end
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))

function start_proccess!(robot)
    steps_count::Int = 1
    while !ismarker(robot)
        for side in ((Nord, West), (Sud, Ost))
            move!(robot, side[1], steps_count)
            move!(robot, side[2], steps_count)
            steps_count += 1
        end
    end
end

r = Robot("start_locations\\8.sit", animate=true)
start_proccess!(r)