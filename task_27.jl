#= 27. Написать рекурсивную функцию, суммирующую все элементы
заданного вектора (реализовать хвостовую рекурсию). =#

sum_recursion(array, last_index::Int = 1, sum::Int = 0) =
if length(array) < last_index
    return sum
else
    sum_recursion(array, last_index+1, sum+array[last_index])
end

print(sum_recursion([1,2,3,4,5]))