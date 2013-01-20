module PostsHelper

	def espn(second)
		key = 'qzbm6t893h5t4va7uctshvrq'
		shared_secret = 'mRteyUnpcucyvrMm3ubsvYDn'
		if (second == "TOP")
			base_uri = 'http://api.espn.com/v1/fantasy/football/news?apikey=qzbm6t893h5t4va7uctshvrq'
			http = Curl.get(base_uri)
			json_body = JSON.parse(http.body_str)
			headlines = json_body['headlines']
			top_titles = []
			headlines.each.with_index do |headline,ind|
				if (ind < 4)
					top_titles.push(headline['title'])
				end
			end
			puts top_titles
			textback = "Top ESPN stories today:\n"
			top_titles.each.with_index do |title,ind|
				textback += ((ind+1).to_s)
				textback += ") "
				textback += title 
				textback += "\n"
			end		
			textback += "mblmstr://espn/top"
			puts textback
			return textback	

		end
	end

	def nyt(second)
		base_uri = ""
		if (second == "TOP")
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/1.json?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"
			http = Curl.get(base_uri)

			json_body = JSON.parse(http.body_str)
			results = json_body['results']
			top_titles = []
			results.each.with_index do |res, ind|
				if (ind < 4)
					top_titles.push(res['title'])
				end
			end

			puts top_titles
			textback = "Top NYT stories today:\n" 
			top_titles.each.with_index do |title,ind|
				textback += ((ind+1).to_s)
				textback += ") "
				textback += title 
				textback += "\n"
			end

			textback += "mblmstr://nyt/top"
			puts textback
			return textback
		elsif (second == "BUS")
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/business/1.json?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"
			http = Curl.get(base_uri)

			json_body = JSON.parse(http.body_str)
			results = json_body['results']
			top_titles = []
			results.each.with_index do |res, ind|
				if (ind < 4)
					top_titles.push(res['title'])
				end
			end

			puts top_titles
			textback = "Top stories today:\n" 
			top_titles.each.with_index do |title,ind|
				textback += ((ind+1).to_s)
				textback += ") "
				textback += title 
				textback += "\n"
			end

			textback += "mblmstr://nyt/bus"
			puts textback
			return textback
		elsif (second == "1")
			nyt_article_request(1)
		elsif (second == "2")
			nyt_article_request(2)
		elsif (second == "3")
			nyt_article_request(3)
		elsif (second == "4")
			nyt_article_request(4)
		elsif (second == "5")
			nyt_article_request(5)

		end
	end

<<<<<<< HEAD
	def ebay(second, third) # avg price for this item on ebay when you type in the name
		# demo popular gift ideas for boys
		#devid = '608eb297-070b-4eab-8e24-79cca0ee7f71'
		#appid = 'EdwardLa-31d7-4979-ac0b-73b558ce7237'
		appid = 'eBayinc2e-d3b4-4a21-a765-47cc6b01cf7'
		#certid = '2d365e22-5625-4015-b178-d84bb1b3d107'

		if (second == "POP")

            base_uri = "http://open.api.ebay.com/shopping?"
		    base_uri += "callname=FindPopularItems&"
		    base_uri += "responseencoding=JSON&"
		    base_uri += "appid="+appid+"&"
		    base_uri += "siteid=0&"
		    base_uri += "version=531&"
		    base_uri += "QueryKeywords="+third


=begin
   http://open.api.ebay.com/shopping?callname=FindPopularItems&responseencoding=JSON&appid=eBayinc2e-d3b4-4a21-a765-47cc6b01cf7&siteid=0&version=531&QueryKeywords=harry%20original
   http://open.api.ebay.com/shopping?
   callname=FindPopularItems&
   responseencoding=XML&
   appid=YourAppIDHere&
   siteid=0&
   version=531&
   QueryKeywords=harry%20original
=end

		elsif (second == "PRICE")
			# max, min and avg
			
			base_uri = "http://svcs.ebay.com/services/search/FindingService/v1"
		    base_uri += "?OPERATION-NAME=findItemsByKeywords"
		    base_uri += "&SERVICE-VERSION=1.0.0"
		    base_uri += "&SECURITY-APPNAME="+appid
		    base_uri += "&GLOBAL-ID=EBAY-US"
		    base_uri += "&RESPONSE-DATA-FORMAT=JSON"
		    base_uri += "&callback=_cb_findItemsByKeywords"
		    base_uri += "&REST-PAYLOAD"
		    base_uri += "&keywords="+third
		    base_uri += "&paginationInput.entriesPerPage=20"

		    http = Curl.get(base_uri)
			json_body = JSON.parse(http.body_str)
			results = json_body['searchResult']

			total_price = 0
			
			count = results['findItemsByKeywords']['searchResult']['@count']
			results = results['findItemsByKeywords']['searchResult']['item']

			min_price = results['sellingStatus']['currentPrice']['__value__'])
			max_price = results['sellingStatus']['currentPrice']['__value__'])
			
			results.each do |res|	
				current_price = res['sellingStatus']['currentPrice']['__value__'])

				if (min_price > current_price) 
					min_price = current_price
				end

				if (max_price < current_price)
					max_price = current_price
				end

				total_price += current_price
			end

			average = total_prices/count
			

			textback = "Current prices for " + third + " on eBay:\n"
			textback += "Minimum price: $" + number_with_precision(min_price, :precision => 2) + "\n"
			textback += "Average price: $" + number_with_precision(average, :precision => 2) + "\n"
			textback += "Maximum price: $" + number_with_precision(max_price, :precision => 2) + "\n"
			textback += "mblmstr://ebay/popular/" + (rand() * 10).to_i + (rand() * 10).to_i + (rand() * 10).to_i
			puts textback
			return textback	
		end
			
		
=begin
		    http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0
		    &SECURITY-APPNAME=eBayinc2e-d3b4-4a21-a765-47cc6b01cf7&GLOBAL-ID=EBAY-US&RESPONSE-DATA-FORMAT=JSON
		    &callback=_cb_findItemsByKeywords&REST-PAYLOAD&keywords=harry%20potter&paginationInput.entriesPerPage=3
=end


	end

	def nyt_article_request(num)
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/1.json?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"
			puts "serving an article request for article #{num}"

			http = Curl.get(base_uri)
			json_body = JSON.parse(http.body_str)
			results = json_body['results']
			top_titles = []
			results.each.with_index do |res, ind|
				if ((ind+1) == num)
					return res['abstract']
				end
			end
			return "Please request one of the three chosen articles"
	end

	def espn_article_request(num)
		base_uri = 'http://api.espn.com/v1/fantasy/football/news?apikey=qzbm6t893h5t4va7uctshvrq'
		http = Curl.get(base_uri)
		json_body = JSON.parse(http.body_str)
		results = json_body['']
	end

	def send_message(text,number)

		caller_id = '+15712978794'
		account_sid = 'AC5c3158c9e08c18f1bd8674a5c9544b42'
      	account_token = '2804511ccef5b294daf82116c75a8f7d'

      	client = Twilio::REST::Client.new(account_sid,account_token)

		if (text.length <= 155)
			client.account.sms.messages.create(
			        :from => caller_id,
			        :to => number,
			        :body => text )   
		else
			chars_sent = 0
			arr = text.split(" ")
			total_length = text.length
			chars_so_far = 0
			chars_in_msg = 0
			message = ''
			arr.each do |word|
				if ((chars_in_msg+word.length) < ( char_so_far.modulo(160)))
					chars_in_msg+=(word.length+1)
					chars_so_far+=(word.length+1)
					message += "#{word} "
				else
					client.account.sms.messages.create(
					        :from => caller_id,
					        :to => number,
					        :body => message )  
					chars_in_msg = 0
					sleep(0.2)					
				end		
			end
		end
	end


	# MAP origin | destination
	def google_maps_pic(text)
		base_uri = 'http://maps.googleapis.com/maps/api/staticmap?size=400x250&key=AIzaSyCr6yfFauBTWNyima_T77tVCCfvIC4-GdE&sensor=false&path=color:0x0000ff|weight:5|'


#		40.737102,-73.990318|40.749825,-73.987963|40.752946,-73.987384|40.755823,-73.986397
	end

end
