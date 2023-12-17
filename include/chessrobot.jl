include("librobot.jl")

mutable struct ChessRobotN <: AbstractRobot
    robot::Robot
    coordinates::Coordinates
    N::Int
    state::Bool
    ChessRobotN(r, N) = new(r, Coordinates(0, 0), N, true) # координаты изначально 0, 0
end

function is_need_putmarker!(robot::ChessRobotN)
    if (ismarker(robot.robot)) return false end
    x, y = get(robot.coordinates)
    x_chess = Int(floor(x / robot.N))
    if ((robot.state && x_chess % 2 == 0) || (!robot.state && x_chess % 2 == 1)) return true end
    return false
end

get_baserobot(robot::ChessRobotN) = robot.robot

function HSR.move!(robot::ChessRobotN, side)
    move!(robot.robot, side)
    move!(robot.coordinates, side)
    x, y = get(robot.coordinates)
    y_chess = Int(floor(y / robot.N))
    if ((!robot.state && y_chess % 2 == 0) || (robot.state && y_chess % 2 == 1)) robot.state = !robot.state end
    if (is_need_putmarker!(robot)) putmarker!(robot.robot) end
end