#= 17. Решить задачу 8 с использованием обобщённой функции
spiral!(stop_condition::Function, robot) =#

include("include\\librobot.jl")

r = Robot("start_locations\\17.sit", animate=true)
spiral!(()->ismarker(r), r)