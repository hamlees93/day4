#Code to convert numbers to words
#Works perfectly for a 3 digit number, but is a bit clunky
#FIXME - make program run again when there is not 3 digits entered

print "Enter a 3 digit number: "
numbers = gets.chomp
if numbers.length == 3
    stringNumbers = ["1","2","3","4","5","6","7","8","9"]
    wordNumbers = [["one","ten","one"],["two","twenty","two"],["three","thirty","three"],["four","forty","four"],["five","fifty","five"],["six","sixty","six"],["seven","seventy","seven"],["eight","eighty","eight"],["nine","ninety","nine"]]
    wordBank = Hash[stringNumbers.zip(wordNumbers)]
    words = []
    i = 0

    while i < 3
        wordBank.each do |key, value|
            if numbers[i] == key
                words[i] = value[i]
                break
            end
        end
        i += 1
    end

    puts words[0].capitalize + " and " + words[1] + " " + words[2]
else
    puts "Incorrect length - Make sure you are only entering 3 digits"
end
