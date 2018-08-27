#Currently have a method to write new username and password to a file. Need to improve method to see if username and password already exist. Then need to save new data in a file titled the persons username . txt that will have their current balance and history of deposits and withdrawals that can be brought into the ruby file

#End game is to have a file called users.txt with all username and password information as hashes, then to have individual files for users that displays their balances

require 'json'

def hash_to_json(data)
    JSON.generate(data)
end

def json_to_hash(data)
    JSON.parse(data)
end

def append_to_file(path, data)
    File.open(path, 'a') do |f|
      f.puts hash_to_json(data)
    end
end

def read_from_file(path)
    $users = []
    File.open(path, 'r') do |f|
      f.each_line do |line|
        hash = json_to_hash(line)
        $users.push(json_to_hash(line)) 
      end
    end
    $users
end

def validate_hashes(hashes)
    hashes.each do |hash|
      result = hash.is_a?(Hash)
      puts 'Value: ' + hash.to_s + ', Is a hash? ' + result.to_s
    end
end


# Seeing if they are a newUser
newUser = false
#returningUser is to see if username exists
returningUser = false
#verified is for password
verified = false
#Making sure withdrawals can occur
enoughMoney = true
# variable so the user can quit
session = true


puts "Welcome to the banking app :) "
puts "Are you a returning user? (yes/no)"

#Check the user file to see if user exists, if they do, they can enter their password. If they don't they will need to add their details
while newUser == false
    returning = gets.chomp.downcase
    if returning == "yes" || returning == "y"
        puts "Please enter your username: "
        read_from_file("users.txt")
        while returningUser == false
            username = gets.chomp.downcase
            if $users.has_key?(username)
                puts "Please enter your password: "
                returningUser = true
                while verified == false
                    realPassword = users.values_at(username).to_s
                    password = '["' + gets.chomp.downcase + '"]'
                    if  password == realPassword
                        puts "Password verified. "
                        verified = true
                    else
                        puts "Incorrect Password. Please enter again. "
                    end
                end
            else
                puts "Username does not exist. Please check spelling and try again. "
            end
        end
        newUser = true
    elsif returning == "no" || returning == "n"
        puts "Please select a username"
        username = gets.chomp.downcase
        puts "Thank you. "
        puts "Please select a password. "
        password = gets.chomp.downcase
        newUserData = {username => password}
        append_to_file("users.txt", newUserData)
        newUser = true
    else
        puts "Incorrect input. Please answer with 'yes' or 'no'."
    end
end


balance = 0
history = []
while balance >= 0 && session
    
    welcome = %Q(
        Hi #{username}!
        What would you like to do?
        1. balance
        2. deposit
        3. withdraw
        4. history
        5. exit
    )
    puts welcome

    action = gets.chomp.downcase

    if action == 'balance' || action == '1'
        puts "Your balance is $#{balance}"
    elsif action == 'deposit' || action == '2'
        puts "How much would you like to deposit? "
        deposit = gets.chomp.to_i
        balance += deposit
        history.append("Deposit worth: #{deposit}. Balance is now: #{balance}")
        puts "Your new balance is $#{balance}"
    elsif action == 'withdraw' || action == '3'
        while enoughMoney == true
            puts "How much would you like to withdraw? "
            withdraw = gets.chomp.to_i
            if (balance - withdraw) < 0
                puts "Unfortunately you do not have enough money. Your current balance is #{balance}. Would you like to try a smaller amount? "
                proceed = gets.chomp.downcase
                if proceed == "yes"
                elsif proceed == "no"
                    enoughMoney = false
                else
                    "Invalid selection"
                end

            else
                balance = balance - withdraw
                history.append("Withdrawal worth: #{withdraw}. Balance is now: #{balance}")
                puts "Your new balance is #{balance}"
            end
        end
    elsif action == 'history' || action == '4'
        puts history
    elsif action == 'exit' || action == '5'
        puts "See you next time. Thanks for stopping by!"
        session = false
    else
        puts "Invalid selection!"
    end

    selection = true
    while selection
        puts "Would you like to make another transaction? (yes/no) "
        decision = gets.chomp.downcase
        if decision == 'yes'
            system "clear"
            selection = false
        elsif decision == 'no'
            puts "Goodbye!!"
            session = false
            selection = false
        else
            puts "Invalid selection"
        end
    end
end

