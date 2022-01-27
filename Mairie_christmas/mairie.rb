require 'nokogiri'
require 'open-uri'

def get_townhall_urls()
  url = "http://annuaire-des-mairies.com/val-d-oise.html"
  html = URI.open(url).read # open the html of the page
  doc = Nokogiri::HTML(html) # create a nokogiri doc based on that html
  towns = doc.xpath("//a[@class='lientxt']").find_all
  towns_array = towns.collect(&:text)
  towns_array2 = towns_array.map {|k| k.downcase.gsub(" ", "-")}
  town_urls = []
  towns_array2.each do |town|
    town_urls << "https://www.annuaire-des-mairies.com/95/#{town}.html"
  end
  return town_urls
end

def get_townhall_email(townhall_url)
  result = []
  townhall_url.each do |url|
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    mail = doc.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").collect(&:text)
    result << "\{#{url.gsub("https://www.annuaire-des-mairies.com/95/","").gsub(".html","").capitalize} => #{mail[0]}\}," + "\n"
  end
  return result
end

puts get_townhall_email(get_townhall_urls())
