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
				if (ind < 6)
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
				if (ind < 6)
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
		elsif (second = "BUS")
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/business/1.json?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"
			http = Curl.get(base_uri)

			json_body = JSON.parse(http.body_str)
			results = json_body['results']
			top_titles = []
			results.each.with_index do |res, ind|
				if (ind < 6)
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
			article_request(1)
		elsif (second == "2")
			article_request(2)
		elsif (second == "3")
			article_request(3)
		elsif (second == "4")
			article_request(4)
		elsif (second == "5")
			article_request(5)

		end
	end

	def article_request(num)
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/1.json?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"


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

	def send_message(text,number)

		caller_id = '+15712978794'
		account_sid = 'AC5c3158c9e08c18f1bd8674a5c9544b42'
      	account_token = '2804511ccef5b294daf82116c75a8f7d'

      	client = Twilio::REST::Client.new(account_sid,account_token)

		if (text.length <= 160)
			client.account.sms.messages.create(
			        :from => caller_id,
			        :to => number,
			        :body => text )   
		else
			chars_sent = 0
			while (chars_sent+1 < text.length)
				message = text[chars_sent..chars_sent+=160]
				client.account.sms.messages.create(
			        :from => caller_id,
			        :to => number,
			        :body => message )  
			     sleep(0.1)			
			end
		end
	end

end
