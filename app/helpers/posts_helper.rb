module PostsHelper

	def nyt(second)
		if (second == "TOP")
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2"
			base_uri+="/mostshared/all-sections/1.json"
			base_uri += "?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"

			http = Curl.get(base_uri)


			json_body = JSON.parse(http.body_str)
			results = json_body['results']
			top_titles = []
			results.each.with_index do |res, ind|
				if (ind < 3)
					top_titles.push(res['title'])
				end
			end

			puts top_titles
			textback = "Top stories today:\n" + "1) " + top_titles[0]+"\n" +  "2) " + top_titles[1]+"\n" +"3) " + top_titles[2]

			o =  [('a'..'z')].map{|i| i.to_a}.flatten
			shortcode  =  (0...3).map{ o[rand(o.length)] }.join
			textback += "\nmblmstr://NYT/top"
			puts textback
			return textback
		elsif (second == "1")
			article_request(1)
		elsif (second == "2")
			article_request(2)
		elsif (second == "3")
			article_request(3)
		end
	end

	def article_request(num)
			base_uri = "http://api.nytimes.com/svc/mostpopular/v2"
			base_uri+="/mostshared/all-sections/1.json"
			base_uri += "?api-key=39186a552e64bb003eb882b3a7486aba:10:67206205"

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

end
