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
			top_titles[0]+" " +top_titles[1]+" " +top_titles[2]
		end
	end

end
