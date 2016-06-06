require 'ultron/autoinit'

arr = __ultron_data || [ 1 ]
arr << arr.max.succ
__ultron_update arr

