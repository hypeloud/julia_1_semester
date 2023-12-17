#= 28. Написать функцию, возвращающую значение n-го члена
последовательности Фибоначчи (1, 1, 2, 3, 5, 8, ...)
а) без использования рекурсии;
б) с использованием рекурсии; =#

function get_number_from_fibonacci(index::Int)
    array = [1, 1]
    for i in 3:index push!(array, (array[i-1] + array[i-2])) end
    return array[index]
end

print(get_number_from_fibonacci(35))