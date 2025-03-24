def bubble_sort(array)
  swapped_times = 1
  while swapped_times > 0 
    swapped_times = 0
    array.each_with_index do |item, index|
      if index < array.length - 1 and item > array[index + 1]
        array[index], array[index + 1] = array[index + 1], item
        swapped_times += 1
      end
    end
  end
  array
end

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([4,13,78,2,10,92])
p bubble_sort([1,1,3,2,-9,92])
p bubble_sort([94,13,78,2,10,92])
p bubble_sort([1,1,1])
p bubble_sort([1,2,3])
p bubble_sort([0])

#=> [0,2,2,3,4,78]
