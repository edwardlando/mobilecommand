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
				if ((chars_in_msg+word.length) < 160)
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
	def google_maps_pic(text)
		base_uri = 'http://maps.googleapis.com/maps/api/staticmap?size=400x250&key=AIzaSyCr6yfFauBTWNyima_T77tVCCfvIC4-GdE&sensor=false&path=color:0x0000ff|weight:5|'
		places = text.split("|")
		origin = places[0]
		destination = places[1]
		origin.gsub!(" ","+")
	    origin.gsub!(",","+")
	    dest.gsub!(" ","+")
	    dest.gsub!(",","+")
	    map_data = ''
	    if origin.nil?
        	return "Sorry, wrong origin address!"
      	elsif dest.nil?
        	return "Sorry, wrong destination address!"
        else
        	total_url+= (origin.html_safe + "|\\" + dest.html_safe)
        end

#		40.737102,-73.990318|40.749825,-73.987963|40.752946,-73.987384|40.755823,-73.986397
	end

end
