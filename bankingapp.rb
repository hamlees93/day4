#Currently have a method to write new username and password to a file. Need to improve method to see if username and password already exist. Then need to save new data in a file titled the persons username . txt that will have their current balance and history of deposits and withdrawals that can be brought into the ruby file

#End game is to have a file called users.txt with all username and password information as hashes, then to have individual files for users that displays their balances


#THIS IS ALL FOR READING/WRITING DATA TO FILE
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
# variable so the user can quit
session = true



#Welcome message
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


#Start of the actual app, setting variables balance and history
balance = 0
history = []
#Balance ensures they still have money. Session is true until the user choses one of the options to quit, then session will be false and the app will exit
while balance >= 0 && session

    #True variable to check that user has enough money for desired withdrawal. If they don't it'll loop back until they do
    enoughMoney = true
    
    #welcome message
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

    #User action
    action = gets.chomp.downcase

    #If/elsif/else statement regarding what user might enter - either the number or word
    #User can either enter the word, or the number associated with the word
    if action == 'balance' || action == '1'
        puts "Your balance is $#{balance}"
    elsif action == 'deposit' || action == '2'
        puts "How much would you like to deposit? "
        #Converting user input to float, so that it can be added to balance
        deposit = gets.chomp.to_f
        balance += deposit
        #FIXME: History is an array that stores transaction history -- will eventually send to file
        history.append("Deposit worth: #{deposit}. Balance is now: #{balance}")
        puts "Your new balance is $#{balance}"
    elsif action == 'withdraw' || action == '3'
        #Will continue looping until user enters an amount they can actually withdraw, or until they choose to exit
        while enoughMoney == true
            puts "How much would you like to withdraw? "
            withdraw = gets.chomp.to_f
            #if the withdrawal will put there account into the negatives, they will not be allowed to continue with the transaction
            if (balance - withdraw) < 0
                puts "Unfortunately you do not have enough money. Your current balance is #{balance}. Would you like to try a smaller amount? "
                #if there isn't enough money in the account, the user will be asked whether they want to continue with a smaller amount. If yes, nothing happens, meaning the while loop will repeat. If no, the variable enoughMoney will become false, thus dropping them out of the loop and back to the initial option screen
                proceed = gets.chomp.downcase
                if proceed == "yes"
                elsif proceed == "no"
                    enoughMoney = false
                else
                    #FIXME: An invalid selection turns it into a yes, when it should repeat the question
                    "Invalid selection"
                end
            #If the user has enough in their account, the withdrawal will occur, and their balance will be the new, lower amount
            else
                balance = balance - withdraw
                history.append("Withdrawal worth: #{withdraw}. Balance is now: #{balance}")
                puts "Your new balance is #{balance}"
            end
        end
    #This option puts the history array, so the user can see their transactions
    elsif action == 'history' || action == '4'
        puts history
    #This option sets the variable session to false, thus breaking out of the initial while loop and allowing the user to quit the application
    elsif action == 'exit' || action == '5'
        puts "See you next time. Thanks for stopping by!"
        session = false
    else
        puts "Invalid selection!"
    end
    #The selection variable exists in case the user enters anything other than 'yes' or 'no', it will loop until they enter one of the allowed options
    selection = true
    while selection
        puts "Would you like to make another transaction? (yes/no) "
        decision = gets.chomp.downcase
        if decision == 'yes'
            #Will clear the terminal window, keeping it all a bit cleaner
            system "clear"
            #Will break out of this loop, and return the users to the start of the bigger loop, thus allowing them to make another decision 
            selection = false
        elsif decision == 'no'
            puts "Goodbye!!"
            #Breaks them out of both this small loop, and the larger loop, allowing them to quit the app
            session = false
            selection = false
        else
            #keeps them in the loop and allows another choice in the effort to get a 'yes' or 'no' from the user
            puts "Invalid selection"
        end
    end
end

