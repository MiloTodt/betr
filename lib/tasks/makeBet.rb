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
        if noOdds?() then return 0 end              
        total = 0
        @odds1.each{ |line| 
            thisOdd = line.to_i
            if(thisOdd > 0) 
                thisOdd -= 100
            elsif(thisOdd < 0)
                thisOdd +=100
            end
            total += thisOdd
        }
        total /= @odds1.size()
        return total - 100 if(total < 0) #Corrects for bets that are between -100 and +100
        return total + 100 if(total >= 0)
        return total
    end
    def odds2Average
        if noOdds?() then return 0 end      
        total = 0
        @odds2.each{ |line| 
            thisOdd = line.to_i
            if(thisOdd > 0) 
                thisOdd -= 100
            elsif(thisOdd < 0)
                thisOdd +=100
            end
            total += thisOdd
        }
        total /= @odds2.size()
        return total - 100 if(total < 0) #Corrects for bets that are between -100 and +100
        return total + 100 if(total >= 0)
        return total
    end
    def margin1
        if noOdds?() then return 0 end
            ((1 - (odds1Average().to_f / @odds1.max().to_f)) * 100).abs()
    end
    def margin2
        if noOdds? then return 0 end
        ((1 - (odds2Average().to_f / @odds2.max().to_f)) * 100).abs()
    end
    def bestMargin
       margin = [margin1(),margin2()].max()
       if margin >= 50 then return 0 end #Something has gone wrong, usually an error with the data source pulled from.
        return margin
    end
    def bestBet
        if (@odds1.size() < 4 or bestMargin() > 50) #Not enough odds to matter.
            return
        end

        if (margin1 > margin2)
            if(odds1Average > 0)
                return "#{@date}, #{@fighters[0]}, #{@odds1.max}, #{margin1().round(2)}" 
            else
                return "#{@date}, #{@fighters[0]}, #{@odds1.min}, #{margin1().round(2)}"
            end 
        else
            if(odds2Average > 0)
                return "#{@date}, #{@fighters[1]}, #{@odds2.max}, #{margin2().round(2)}"
            else
                return "#{@date}, #{@fighters[1]}, #{@odds2.min}, #{margin2().round(2)}"
            end
        end
    end
end

def isDate?(input) #date lines start with 2017, no other lines start with numbers
    return input[0] == "2"
end
def isAnOdd?(input) #refers to whether the line is a betting odd, not odd/even
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
    elsif(isAnOdd?(line))
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


file = File.new("madeBets.txt", "a")
file.write(fights[indexBig].bestBet + "\n")
file.close

#for debugging
# fights.each{|fight| 
#     puts fight.fighters
#     puts fight.bestBet
# }