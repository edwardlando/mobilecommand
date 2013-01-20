module PostsHelper
	include ActionView::Helpers::NumberHelper

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

	def ebay(second, third, preserved_body) # avg price for this item on ebay when you type in the name

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



		elsif (second == "PRICE")
			# max, min and avg

			third = third.gsub(" ", "%20")

			base_uri = "http://ql.io/q?s=result%20%3D%20select%20%22sellingStatus.currentPrice.%24t%22%20from%20finditems%20where%20keywords%3D%22" + third + "%22%0A%0Areturn%20%7B%0A%09%22result%22%20%3A%20%22%7Bresult%7D%22%20%7D"
			#base_uri = "http://ql.io/q?s=select%20%22sellingStatus.currentPrice.%24t%22%20from%20finditems%20where%20keywords='" + third + "'"

			p '****'
			p base_uri
			p '****'

		    http = Curl.get(base_uri)
			json_body = JSON.parse(http.body_str)

			json_body = json_body['result']

			total_price = 0
			count = 0

			min_price = json_body[0].to_i
			max_price = json_body[0].to_i
			
			json_body.each do |res|
				res = res.to_i	


				if (min_price > res) 
					min_price = res
				end

				if (max_price < res)
					max_price = res
				end

				total_price += res

				count += 1
			end

			average = total_price/count

			textback = "Current prices for " + preserved_body + " on eBay:\n"
			textback += "Minimum price: $" + number_with_precision(min_price, :precision => 2) + "\n"
			textback += "Average price: $" + number_with_precision(average, :precision => 2) + "\n"
			textback += "Maximum price: $" + number_with_precision(max_price, :precision => 2) + "\n"
			textback += "mblmstr://ebay/popular/" + (0...4).map{ ('a'..'z').to_a[rand(26)] }.join
			puts textback
			return textback	
		end
	end

=begin
		    http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0
		    &SECURITY-APPNAME=eBayinc2e-d3b4-4a21-a765-47cc6b01cf7&GLOBAL-ID=EBAY-US&RESPONSE-DATA-FORMAT=JSON
		    &callback=_cb_findItemsByKeywords&REST-PAYLOAD&keywords=harry%20potter&paginationInput.entriesPerPage=3
=end


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

				if ((chars_in_msg+word.length) < ( chars_so_far.modulo(160)))

				#if ((chars_in_msg+word.length) < 160)

					chars_in_msg+=(word.length+1)
					chars_so_far+=(word.length+1)
					message += "#{word} "
				else
					client.account.sms.messages.create(
					        :from => caller_id,
					        :to => number,
					        :body => message )  
					chars_in_msg = 0
					message = ''
					sleep(0.2)					
				end		
			end
		end
	end


	# MAP origin | destination
	def google_maps_pic(text,number)

		caller_id = '+15712978794'
		account_sid = 'AC5c3158c9e08c18f1bd8674a5c9544b42'
      	account_token = '2804511ccef5b294daf82116c75a8f7d'

      	client = Twilio::REST::Client.new(account_sid,account_token)

		base_uri = 'http://maps.googleapis.com/maps/api/staticmap?size=250x140&key=AIzaSyCr6yfFauBTWNyima_T77tVCCfvIC4-GdE&sensor=false&path=color:0x0000ff|weight:5|'
		places = text.split("|")
		origin = places[0]
		dest = places[1]
		text.gsub!(" ","+")
		text.gsub!(",","+")

	    text.gsub!("|","|\\")
	        client.account.sms.messages.create(
	        	:from => caller_id,
	        	:to => number,
	        	:body => base_uri+text.html_safe )

	end

		def get_directions(origin,dest,from)
    arr = Array.new
    msg = ''
    origin.gsub!(" ","+")
    origin.gsub!(",","+")
    dest.gsub!(" ","+")
    dest.gsub!(",","+")
    uri = "http://maps.googleapis.com"
    map_data = ''
      req = Curl.get(uri + '/maps/api/geocode/json?address=' + origin.html_safe + '&sensor=false')
      origin = JSON.parse(req.body_str)['results']
      req = Curl.get(uri + '/maps/api/geocode/json?address=' + dest.html_safe + '&sensor=false')
      dest = JSON.parse(req.body_str)['results']
      if origin.nil?
        send_message("Invalid origin",from)
      elsif dest.nil?
        send_message("Invalid destination",from)
      else
        origin = origin[0]['geometry']['location']
        dest = dest[0]['geometry']['location']
        dest_lat = dest['lat']
        dest_lng = dest['lng']
        origin_lat = origin['lat']
        origin_lng = origin['lng']
        params = (uri + '/maps/api/directions/json?origin=' + origin_lat.to_s + "," +origin_lng.to_s + '&destination=' + dest_lat.to_s + "," + dest_lng.to_s + '&sensor=false').html_safe
        req = Curl.get(params)
        map_data = JSON.parse(req.body_str)['routes'][0]['legs'][0]['steps']
 
      end
    map_data.each do |step| 
      h = Hash.new
      puts step
      instr = step['html_instructions']
      dist_string = step['distance']['text']

      instr.gsub!("<b>","")
      instr.gsub!("</b>","")
      instr=instr.split("<div")[0]
      h['instructions'] = instr
      h['distance'] = dist_string
      puts "WHAT"
      puts h['instructions']
      puts h['distance']
      puts "KEOFK"
      arr.push(h)


    #  puts msg
    end
          msg+="Directions:\n"
          arr.each.with_index do |point,ind|
      	curr = ''
      	curr+=((ind+1).to_s+") ")
      	curr+=(point['distance'].to_s+" ")
      	curr+=(point['instructions']+"\n")
      	msg+=curr
     # 	msg+=curr[0..(curr.length/2)]
      end
    msg  
  end

	def duckduckgo(text)
		base_uri = 'http://api.duckduckgo.com/?q=^&format=json'
		text.gsub!(" ","+")
		text.gsub!(",","+")
		base_uri.gsub!("^",text)
		http = Curl.get(base_uri)
		json_body = JSON.parse(http.body_str)
		topics = json_body['RelatedTopics']
		message = 'Possible Answers\n'
		puts topics
		topics.each.with_index do |t,ind|
			if (t['Text'] != nil)
				puts t['Text']
				message += (ind+1).to_s
				message += ") "
				message += t['Text']
				message += "\n"
			else
				break
			end
		end
		message
	end
end

