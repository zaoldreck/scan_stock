require 'nokogiri'
require 'open-uri'

head = 'table tr td table tr td'
hash = Hash.new

doc = Nokogiri::HTML(open('http://www.set.or.th/set/factsheet.do?symbol=PM&language=en&country=us'))
hash['name'] = doc.css('table tr td table tr td.factsheet-heading2').text
hash['sector'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[0].text.split('/')[0]
hash['group'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[0].text.split('/')[1]
hash['index'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[1].text

doc.css('table tr').each_with_index do | item , index|
  if index==3
    item.css('td table')[1].css('tr td table').each_with_index do | item2 , index2|
      puts index2
      puts item2
      # if index2==4
      #   puts index2
      #   puts item2
      # end
    end
  end
end




# doc.css('table tr').each_with_index do | item , index|
#   puts index
#   puts item
# end


# puts doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')

# Example

####
# doc.css('nav ul.menu li a').each do |link|
#   puts link.content
# end

####
# Search for nodes by xpath
# doc.xpath('//h2 | //h3').each do |link|
#   puts link.content
# end

####
# Or mix and match.
# doc.search('code.sh', '//h2').each do |link|
#   puts link.content
# end
