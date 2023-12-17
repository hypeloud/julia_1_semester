#= 28. Написать функцию, возвращающую значение n-го члена
последовательности Фибоначчи (1, 1, 2, 3, 5, 8, ...)
а) без использования рекурсии;
б) с использованием рекурсии; =#

function get_number_from_fibonacci_recursion(index::Int)
    if index <= 2
        return 1
    else 
        return get_number_from_fibonacci_recursion(index-2) + get_number_from_fibonacci_recursion(index-1)
    end
end

print(get_number_from_fibonacci_recursion(35))