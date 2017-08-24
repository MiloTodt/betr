class Fight
    def initialize(date)
	@date = date
    @fighters = Array.new(2)
	@odds1 = []
	@odds2 = []
    end
    def date
        @date
    end
    def fighters
        @fighters
    end
    def fighters=(value)
        @fighters = value
    end
    def odds1
        @odds1
    end
    def odds1Add(value)
        @odds1 << value
    end
    def odds2
        @odds1
    end
    def odds2Add(value)
        @odds2 << value
    end
end
def isDate?(input) #date lines start with 2017, no other lines start with numbers
    return input[0] == "2"
end
def isOdd?(input)
    return (input[0] == "+" or "-")
end
if test
    
elsif 
    
else
    
end


fights = [] #Create an array of BetLine objects, each holding the betting information for one fighter.
file = File.new("betInfo.txt", "r")
while (line = file.gets)
if (isDate?(line)) #dealing with a date, make new fight
    thisFight = Fight.new(line.strip)
    thisFight.fighters = file.gets.strip.split(" vs ")
elsif(isOdd?(line))
    thisFight.odds1Add(line.strip)
    thisFight.odds2Add(file.gets.strip)
end
fights << thisFight
end

    betInfo.push(BetLine.new(line.chomp.split(',')))
end
file.close
 
betInfo.each{|line| line.bestBet}

class BetLine
    def initialize(input)
        @name = input[0]
        @lines = Array[input[1].to_i , input[2].to_i , input[3].to_i , input[4].to_i , input[5].to_i, input[6].to_i, input[7].to_i, input[8].to_i, input[9].to_i, input[10].to_i, input[11].to_i, input[12].to_i]
 
        """
        for i in range(listNums):
            list.append(i)
        """
    end
 
    def printLines()
        @lines.each {|line| puts line}
    end
    def average
        total = 0
        @lines.each{ |line| total += line}
        total /= @lines.size()
        return total - 100 if(total < 0 && total > -100) #Corrects for bets that are between -100 and +100
        return total + 100 if(total >= 0 && total < 100)
        return total
    end
    def indexLargest #Should be smallest? Abs here might cause unexpected behaviour.
        biggest = 0
        index = 0
        for i in 0...@lines.size()
            if @lines[i].abs > biggest
                biggest = @lines[i].abs
                index = i
            end
        end
    index
    end
    def numberLargest
        @lines.min()
    end
    def margin
         ((1 -(average().to_f / numberLargest().to_f)) * 100).abs()
    end
    def bestBet
        puts "The best bet for #{@name} is at #{numberLargest()} with a margin of #{margin()}%."
    end
end
 
betInfo = [] #Create an array of BetLine objects, each holding the betting information for one fighter.
file = File.new("betInfo.txt", "r")
while (line = file.gets)
    betInfo.push(BetLine.new(line.chomp.split(',')))
end
file.close
 
betInfo.each{|line| line.bestBet}
 
 
indexBig = 0
marginBig = 0
for i in 0...betInfo.size()
    if betInfo[i].margin > marginBig
        indexBig = i
        marginBig = betInfo[i].margin
    end
end
 
betInfo[indexBig].bestBet
