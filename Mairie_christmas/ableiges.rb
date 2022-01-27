require 'nokogiri'
require 'open-uri'

email_url = "http://annuaire-des-mairies.com/95/ableiges.html"
html = URI.open(email_url).read # open the html of the page
doc = Nokogiri::HTML(html)

towns = doc.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").find_all
towns_array = towns.collect(&:text)

puts towns_array
