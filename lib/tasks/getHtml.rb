require 'open-uri'

url = 'https://www.sportsbookreview.com/betting-odds/ufc/'
source = open(url){|f|f.read}

File.write('betHtml.txt', source)
