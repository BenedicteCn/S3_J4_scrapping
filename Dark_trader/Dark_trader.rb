require 'nokogiri'
require 'open-uri'

url = "https://coinmarketcap.com/all/views/all/"
html = URI.open(url).read # open the html of the page
doc = Nokogiri::HTML(html) # create a nokogiri doc based on that html

name = doc.xpath("//a[@class='cmc-table__column-name--symbol cmc-link']").find_all
name_array = name.collect(&:text)

price = doc.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[@class="cmc-table-row"]/td[5]').find_all
price_array = price.collect(&:text)

#final_hash = [Hash[name_array.zip(price_array)]]

final_array = []
name_array.each_with_index do |k, index|
  final_array << "\{#{k} => #{price_array[index]}\}," + "\n"

end
puts final_array
