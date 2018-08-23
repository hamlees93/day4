#FIXME: Code doesn't work in current state. It will spit out a number, but the unique aspect of it isn't working. I.e. the following example; copies = [1,1,2,2,3,3,4,5], gets 5 unique items, which is true, but then the formula gives those 5 a discount, then charges the other 2 at full price...whereas it should charge them in 2 lots of 4 unique purchases, and give a 20% discount to both

copies = [1,1,2,2,3,3,4,5]

unique = copies.uniq.count
total = copies.count

puts unique
puts total

if unique == 1
    discount = 0
elsif unique == 2
    discount = 0.05
elsif unique == 3
    discount = 0.1
elsif unique == 4
    discount = 0.20
else
    discount = 0.25
end

cost = (unique * 8) * (1 - discount) + ((total - unique) * 8)

puts cost
