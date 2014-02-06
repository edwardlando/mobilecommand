require 'json'
require 'mechanize'
require 'csv'
require 'nokogiri'
require 'open-uri'


# We are just doing bills [later, amendments and votes] for now, and specifically house bills
# [later, senate bills, resolutions, etc.]
def get_page_from_nokogiri(congress_number, hr_number)
	url = "https://www.govtrack.us/data/congress/"+congress_number.to_s+"/bills/hr/hr"+hr_number.to_s+"/data.json"
	doc = Nokogiri::HTML(open(url))
	doc
end

#puts get_page_from_nokogiri(113, 1007)