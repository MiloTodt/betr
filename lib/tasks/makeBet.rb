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
        @odds2
    end
    def odds2Add(value)
        @odds2 << value
    end
    def noOdds?
        return @odds1.size == 0
    end

    def odds1Average
        total = 0
        @odds1.each{ |line| total += line.to_i}
        total /= @odds1.size()
        return total - 100 if(total < 0 && total > -100) #Corrects for bets that are between -100 and +100
        return total + 100 if(total >= 0 && total < 100)
        return total
    end
    def odds2Average
        total = 0
        @odds2.each{ |line| total += line.to_i}
        total /= @odds2.size()
        return total - 100 if(total < 0 && total > -100) #Corrects for bets that are between -100 and +100
        return total + 100 if(total >= 0 && total < 100)
        return total
    end
    def margin1
        if noOdds?() then return 0 end
        ((1 -(odds1Average().to_f / @odds1.min().to_f)) * 100).abs()
    end
    def margin2
        if noOdds? then return 0 end
        ((1 -(odds2Average().to_f / @odds2.min().to_f)) * 100).abs()
    end
    
    def bestMargin
        [margin1(),margin2()].max()
    end
    def bestBet
        if @odds1.size() < 3
            return
            return "Not more than three different odds yet!"
        end
        if noOdds? 
             return "No odds for this fight yet!"
            elsif (margin1 > margin2)
                return "#{@date} #{@fighters[0]} #{@odds1.min} #{margin1()}"
                
            else
                return "#{@date} #{@fighters[1]} #{@odds2.min} #{margin2()}"
            end
    end
end

def isDate?(input) #date lines start with 2017, no other lines start with numbers
    return input[0] == "2"
end
def isOdd?(input)
    return (input[0] == "+" or "-")
end

fights = [] #Create an array of BetLine objects, each holding the betting information for one fighter.
file = File.new("betInfo.txt", "r")
thisFight = Fight.new(-1)
firstFlag = 1
while (line = file.gets) != nil
    if (isDate?(line)) #dealing with a date, make new fight
        if(firstFlag != 1)
            fights << thisFight
        end
        thisFight = Fight.new(line.strip)
        thisFight.fighters = file.gets.strip.split(" vs ")
        firstFlag = 0
    elsif(isOdd?(line))
        thisFight.odds1Add(line.strip)
        thisFight.odds2Add(file.gets.strip)
    end
end
fights << thisFight
file.close


indexBig = 0
for i in 0...fights.size()
    if fights[i].bestMargin > fights[indexBig].bestMargin
        indexBig = i
    end
end

fights.each{|fight|
     puts fight.bestBet
}


file = File.new("madeBets.txt", "a")
file.write(fights[indexBig].bestBet)
file.close