require 'open-uri'

url = 'https://www.sportsbookreview.com/betting-odds/ufc/'
source = open(url){|f|f.read}

File.open("betHtml.txt", "w") do |f|
    f.write(source)
end
