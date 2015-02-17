require 'nokogiri'
require 'open-uri'

head = 'table tr td table tr td'
hash = Hash.new
hash_financial_q = Hash.new
hash_financial_q_last = Hash.new
hash_financial_y = Hash.new
hash_financial_y_last = Hash.new
# doc = Nokogiri::HTML(open('http://www.set.or.th/set/factsheet.do?symbol=PM&language=th&country=th'))
doc = Nokogiri::HTML(open('http://www.set.or.th/set/factsheet.do?symbol=PM&language=en&country=us'))
hash['name'] = doc.css('table tr td table tr td.factsheet-heading2').text
hash['sector'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[0].text.split('/')[0]
hash['group'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[0].text.split('/')[1]
hash['index'] = doc.css('table tr td table tr td table tr td.factsheet-noline table tr td')[1].text

doc.css('table tr').each_with_index do | item , index|
  if index==3
    item.css('td table')[1].css('tr td table').each_with_index do | item2 , index2|
      ######
        # puts index2
        # puts item2
      if index2 == 4
        #Company Profile
      elsif index2 == 5
        #Business
        hash['business'] =  item2.css('tr td.factsheet').text
      elsif index2 == 9
        #Price Performance (Adjusted Price)
        arrStock = []
        arrSector = []
        arrMarket = []
        item2.css('tr').each_with_index do | pp , index_pp|
          # puts index_pp
          # puts pp
          if index_pp == 3
            #5 Days
            arrStock[0] = pp.css('td')[1].text
            arrSector[0] = pp.css('td')[2].text
            arrMarket[0] = pp.css('td')[3].text
          elsif index_pp == 4
            #20 Days
            arrStock[1] = pp.css('td')[1].text
            arrSector[1] = pp.css('td')[2].text
            arrMarket[1] = pp.css('td')[3].text
          elsif index_pp == 5
            #60 Days
            arrStock[2] = pp.css('td')[1].text
            arrSector[2] = pp.css('td')[2].text
            arrMarket[2] = pp.css('td')[3].text
          elsif index_pp == 6
            #120 Days
            arrStock[3] = pp.css('td')[1].text
            arrSector[3] = pp.css('td')[2].text
            arrMarket[3] = pp.css('td')[3].text
          elsif index_pp == 7
            #YTD
            arrStock[4] = pp.css('td')[1].text
            arrSector[4] = pp.css('td')[2].text
            arrMarket[4] = pp.css('td')[3].text
          elsif index_pp == 8
            #PE(X)
            arrStock[5] = pp.css('td')[1].text
            arrSector[5] = pp.css('td')[2].text
            arrMarket[5] = pp.css('td')[3].text
          elsif index_pp == 9
            #P/BV(X)
            arrStock[6] = pp.css('td')[1].text
            arrSector[6] = pp.css('td')[2].text
            arrMarket[6] = pp.css('td')[3].text
          elsif index_pp == 10
            #Turnover Ratio (%)
            arrStock[7] = pp.css('td')[1].text
            arrSector[7] = pp.css('td')[2].text
            arrMarket[7] = pp.css('td')[3].text
          end

        end
        hash['compare_stock'] = arrStock
        hash['compare_sector'] = arrSector
        hash['compare_market'] = arrMarket
        #end index2,9
      elsif index2 == 12
        arrYtd = []
        arrThis = []
        arrLast = []
        item2.css('tr').each_with_index do | static , index_static |
          # puts index_static
          # puts static
          if index_static == 1
            #date
            arrYtd[0] = Nokogiri::HTML(static.css('td strong')[1].to_s.split('<br>').join(" ") ).text
            arrThis[0] = Nokogiri::HTML(static.css('td strong')[2].to_s.split('<br>').join(" ") ).text
            arrLast[0] = Nokogiri::HTML(static.css('td strong')[3].to_s.split('<br>').join(" ") ).text
          elsif index_static == 4
            #Listed share (M.)
            arrYtd[1] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[1] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[1] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 5
            #Par Value (B.)
            arrYtd[2] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[2] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[2] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 6
            #Market Cap (MB.)
            arrYtd[3] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[3] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[3] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 7
            #Price (B./share)
            arrYtd[4] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[4] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[4] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 8
            #BVPS (B./Share)
            arrYtd[5] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[5] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[5] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 9
            #P/BV (X)
            arrYtd[6] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[6] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[6] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 10
            #P/E (X)
            arrYtd[7] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[7] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[7] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 11
            #Turnover Ratio (%)
            arrYtd[8] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[8] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[8] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 12
            #Value Trade/Day (MB.)
            arrYtd[9] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[9] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[9] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 14
            #Rate of Return
            arrYtd[10] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[10] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[10] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 17
            #Price Change (%)
            arrYtd[11] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[11] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[11] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 18
            #Dividend Yield (%)
            arrYtd[12] = static.css('td')[1].text.gsub(/[^.0-9A-Za-z]/, '')
            arrThis[12] = static.css('td')[2].text.gsub(/[^.0-9A-Za-z]/, '')
            arrLast[12] = static.css('td')[3].text.gsub(/[^.0-9A-Za-z]/, '')
          elsif index_static == 19
            #Dividend Policy
            hash['dividend_policy'] = static.css('td')[1].text
          end
        end
        hash['static_ytd'] = arrYtd
        hash['static_this'] = arrThis
        hash['static_last'] = arrLast

      elsif index2 == 13
        #Dividend
        arrDividend = []
        item2.css('tr').each_with_index do | dividend , index_dividend |
          # puts index_dividend
          # puts dividend
          if index_dividend >= 4
            dividend_hash = Hash.new
            dividend_hash['operation_period'] = dividend.css('td')[0].text
            dividend_hash['dividend_share'] = dividend.css('td')[1].text
            dividend_hash['unit'] = dividend.css('td')[2].text
            dividend_hash['payment'] = dividend.css('td')[3].text
            dividend_hash['type'] = dividend.css('td')[4].text
            arrDividend.push( dividend_hash )
            # puts dividend_hash
          end
        end
         hash['dividend'] = arrDividend
      elsif index2 == 17
        #Financial Position
        arrName = []
        keyName1,keyName2,keyName3,keyName4 = ''
        item2.css('tr').each_with_index do | financial_position , index_financial_position |
          # puts index_financial_position
          # puts financial_position
          if index_financial_position > 2 && (item2.css('tr').size-1) != index_financial_position
            arrName.push( financial_position.css('td')[0].text )
            tempName = financial_position.css('td')[0].text.strip
            hash_financial_q[tempName] = financial_position.css('td')[1].text
            hash_financial_q_last[tempName] = financial_position.css('td')[2].text
            hash_financial_y[tempName] = financial_position.css('td')[3].text
            hash_financial_y_last[tempName] = financial_position.css('td')[4].text
          end
        end
      elsif index2 == 18
        # Comprehensive Income
        arrName = []
        item2.css('tr').each_with_index do | financial_income , index_financial_income |
          # puts index_financial_income
          # puts financial_income
          if index_financial_income > 2 && (item2.css('tr').size-1) != index_financial_income
            arrName.push( financial_income.css('td')[0].text )
            tempName = financial_income.css('td')[0].text.strip
            hash_financial_q[tempName] = financial_income.css('td')[1].text
            hash_financial_q_last[tempName] = financial_income.css('td')[2].text
            hash_financial_y[tempName] = financial_income.css('td')[3].text
            hash_financial_y_last[tempName] = financial_income.css('td')[4].text
          end
        end
      elsif index2 == 19
        # Cash Flow
        arrName = []
        item2.css('tr').each_with_index do | cash_flow , index_cash_flow |
          # puts index_cash_flow
          # puts cash_flow
          if index_cash_flow > 2 && (item2.css('tr').size-1) != index_cash_flow
            arrName.push( cash_flow.css('td')[0].text )
            tempName = cash_flow.css('td')[0].text.strip
            hash_financial_q[tempName] = cash_flow.css('td')[1].text
            hash_financial_q_last[tempName] = cash_flow.css('td')[2].text
            hash_financial_y[tempName] = cash_flow.css('td')[3].text
            hash_financial_y_last[tempName] = cash_flow.css('td')[4].text
          end
        end
      elsif index2 == 20
        # Ratios
        arrName = []
        item2.css('tr').each_with_index do | ratios , index_ratios|
          # puts index_ratios
          # puts ratios
          if index_ratios == 1
            arrName.push( ratios.css('td')[0].text )
            tempName = ratios.css('td')[0].text.strip
            hash_financial_q['head'] = ratios.css('td')[1].text.gsub(/[^.\/0-9A-Za-z]/, '')
            hash_financial_q_last['head'] = ratios.css('td')[2].text.gsub(/[^.\/0-9A-Za-z]/, '')
            hash_financial_y['head'] = ratios.css('td')[3].text.gsub(/[^.\/0-9A-Za-z]/, '')
            hash_financial_y_last['head'] = ratios.css('td')[4].text.gsub(/[^.\/0-9A-Za-z]/, '')
          elsif index_ratios > 3
            arrName.push( ratios.css('td')[0].text )
            tempName = ratios.css('td')[0].text.strip
            hash_financial_q[tempName] = ratios.css('td')[1].text
            hash_financial_q_last[tempName] = ratios.css('td')[2].text
            hash_financial_y[tempName] = ratios.css('td')[3].text
            hash_financial_y_last[tempName] = ratios.css('td')[4].text
          end
        end
      elsif index2 == 22
        # Growth Rate
        arrName = []
        item2.css('tr').each_with_index do | growth_rate , index_growth_rate |
          # puts index_growth_rate
          # puts growth_rate
          if index_growth_rate > 3
            arrName.push( growth_rate.css('td')[0].text )
            tempName = growth_rate.css('td')[0].text.strip
            hash_financial_q[tempName] = growth_rate.css('td')[1].text
            hash_financial_q_last[tempName] = growth_rate.css('td')[2].text
            hash_financial_y[tempName] = growth_rate.css('td')[3].text
            hash_financial_y_last[tempName] = growth_rate.css('td')[4].text
          end
        end
      elsif index2 == 23
        # Cash Cycle
        arrName = []
        item2.css('tr').each_with_index do | cash_cycle , index_cash_cycle |
          # puts index_cash_cycle
          # puts cash_cycle
          if index_cash_cycle > 3
            arrName.push( cash_cycle.css('td')[0].text )
            tempName = cash_cycle.css('td')[0].text.strip
            hash_financial_q[tempName] = cash_cycle.css('td')[1].text
            hash_financial_q_last[tempName] = cash_cycle.css('td')[2].text
            hash_financial_y[tempName] = cash_cycle.css('td')[3].text
            hash_financial_y_last[tempName] = cash_cycle.css('td')[4].text
          end
        end

      end
      # if index2==4
      #   puts index2
      #   puts item2
      # end
    end
  end
end

# puts hash
puts hash_financial_q

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
