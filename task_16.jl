#= 16. Решить задачу 7 с использованием обобщённой функции
shuttle!(stop_condition::Function, robot, side) =#

include("include\\librobot.jl")

r = Robot("start_locations\\16.sit", animate=true)
shuttle!(()->!isborder(r, Nord), r; start_side=Ost)