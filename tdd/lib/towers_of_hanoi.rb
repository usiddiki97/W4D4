require "byebug"

class InvalidNumber < StandardError
end
class DifferentTowers < StandardError
end
class EmptyTower < StandardError
end
class BiggerDisc < StandardError
end


class TowersOfHanoi
    attr_accessor :poles 

    def initialize
        @poles = [[5,4,3,2,1], [], []]
    end
  
    def play
        system("clear")
        count = 0
        until won?
            render
            puts "The goal of the game is to move all the discs on Tower 1 to Tower 3 in that order"
            puts "Please enter a start and destination tower with a space in between like: '0 1' "
            begin
                input = get_input
                # debugger
            rescue InvalidNumber => e
                puts e.message
                retry
            rescue DifferentTowers => e
                puts e.message
                retry
            rescue EmptyTower => e
                puts e.message
                retry
            rescue BiggerDisc => e
                puts e.message
                retry
            end
            move(input)
            count += 1
            system("clear")
        end
        render
        puts
        puts "🥳   🎉   🎊 "
        puts
        puts "Finished the game in #{count} moves"
        puts
        if count == 31
            puts "Congrats! You're officially a genius! :^)"
        elsif count.between?(32,40)
            puts "Look at this smarty-pants :')"
        elsif count.between?(41,55)
            puts "Nice work, but could be done faster :^0"
        else
            puts "You're kinda dumb bro, maybe try a different game :'/"
        end
    end

    def move(input)
        start_pole, end_pole = input
        @poles[end_pole].push(@poles[start_pole].pop)
    end

    def won?
        @poles == [[], [], [5, 4, 3, 2, 1]]
    end
    

    def get_input
        input = gets.chomp.split(" ").map(&:to_i) 
        
        if input.any? {|n| !n.between?(1,3)} #if any of input's ele is not between 0 and 2
            raise InvalidNumber.new("Please enter numbers between 1 and 3")
        end
        start_pole = input.first - 1
        end_pole = input.last - 1
        raise DifferentTowers.new("Start and destination towers have to be different" )if start_pole == end_pole
        raise EmptyTower.new("There must be a disc at your starting tower") if @poles[start_pole].empty?
        raise BiggerDisc.new("Can't stack bigger disc on smaller disc") if !@poles[end_pole].empty? && @poles[start_pole].last > @poles[end_pole].last 
        
        input = start_pole, end_pole
    end

    def render
        puts "Tower 1: #{@poles[0].join("  ")}"
        puts "         ------------"
        puts "Tower 2: #{@poles[1].join("  ")}"
        puts "         ------------"
        puts "Tower 3: #{@poles[2].join("  ")}"
    end

end  

towers = TowersOfHanoi.new

p towers.play
# Towers of Hanoi

# Write a Towers of Hanoi game.

# Keep three arrays, which represents the piles of discs. Pick a representation
# of the discs to store in the arrays; maybe just a number representing their
# size. Don't worry too much about making the user interface pretty.

# In a loop, prompt the user (using gets) and ask what pile to select a disc from,
# and where to put it.

# After each move, check to see if they have succeeded in moving all the discs,
# to the final pile. If so, they win!

# Note: don't worry about testing the UI. Testing console I/O is tricky (don't
# bother checking gets or puts). Focus on: