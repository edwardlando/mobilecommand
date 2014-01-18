require 'json'
require 'mechanize'
require 'csv'

a = Mechanize.new 

results = a.get('https://www.govtrack.us/api/v2/bill?congress=112&limit=600')
# data = JSON.parse(results.content)["data"]
data = JSON.parse(results.body)
# data["objects"].each do |d| 
# 	puts d["bill_type"]
# end
# puts data["objects"][0].keys

array_main = []

data["objects"].each do |d|
	unless d.keys.nil?
		array_current = d.keys
		array_main |= array_current
	end
end

p array_main



CSV.open('billsCongress112.csv', 'ab') do |csv|
	csv << ["bill_resolution_type", "bill_type", "bill_type_label", "congress", "current_status", 
		    "current_status_date", "current_status_description", "current_status_label", "display_number",
		    "docs_house_gov_postdate", "id", "introduced_date", "is_alive", "is_current", "link", "major_actions",
		    "noun", "number", "senate_floor_schedule_postdate", "sliplawnum", "sliplawpubpriv", "source", "source_link",
		    "sponsor", "sponsor_role", "thomas_link", "title", "title_without_number", "titles"]
	csv << []
	data["objects"].each do |d|
		row  = []
		bill_resolution_type = d["bill_resolution_type"]
		bill_type_label = d["bill_type_label"]
		congress = d["congress"]
		current_status = d["current_status"]
		current_status_date = d["current_status_date"]
		current_status_description = d["current_status_description"]
		current_status_label = d["current_status_label"]
		display_number = d["display_number"]	
		docs_house_gov_postdate = d["docs_house_gov_postdate"]
		id = d["id"]
		introduced_date = d["introduced_date"]
		is_alive = d["is_alive"]
		is_current = d["is_current"]	
		link = d["link"]	
		major_actions = d["major_actions"]
		noun = d["noun"]
		number = d["number"]
		senate_floor_schedule_postdate = d["senate_floor_schedule_postdate"]
		sliplawnum = d["sliplawnum"]	
		sliplawpubpriv = d["sliplawpubpriv"]
		source = d["source"]
		source_link = d["source_link"]
		sponsor = d["sponsor"]
		sponsor_role = d["sponsor_role"]
		thomas_link = d["thomas_link"]
		title = d["title"]
		title_without_number = d["title_without_number"]
		titles = d["titles"]

			row << bill_resolution_type
			row << bill_type_label
			row << congress
			row << current_status
			row << current_status_date
			row << current_status_description
			row << current_status_label
			row << display_number
			row << docs_house_gov_postdate
			row << id
			row << introduced_date
			row << is_alive
			row << is_current
			row << link
		    row << major_actions
			row << noun
			row << number
			row << senate_floor_schedule_postdate
			row << sliplawnum
			row << sliplawpubpriv
			row << source
			row << source_link
			row << sponsor
			row << sponsor_role
			row << thomas_link
			row << title
			row << title_without_number
			row << titles
	
			csv << row
	end
end
				