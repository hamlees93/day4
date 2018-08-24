#Start i from index 2, as numbers 1 and 2 are special cases
#Go up by 2, as all even numbers are not prime numbers
primeNumber = [2]
i = 3
j = 2
while i < 100
    while j < i 
        if i % j == 0 
            j = i
        elsif i % j != 0 && i - j > 1
            j += 1
        else
            primeNumber.append(i)
            j = i
        end
    end
    i += 2
    j = 2
end

p primeNumber

    
#Below is prime calculated 'cheating' by uploading 'prime'
=begin
require 'prime'

x =  (1..100).to_a
primeNumber = []

i = 0
while i < 100
    if Prime.prime?(i)
        primeNumber.append(i)
        i += 1
    else
        i += 1
    end
end

p primeNumber
=end