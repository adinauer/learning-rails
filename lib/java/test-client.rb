require 'java'

require 'fhbay-commons.jar'
require 'fhbay-client-commons.jar'
require 'jboss-client.jar'
require 'hibernate-core-4.1.9.Final.jar'

java_import 'at.dinauer.fhbay.presentation.PmodArticle'
java_import 'at.dinauer.fhbay.util.DataFetcher'
java_import 'at.dinauer.fhbay.util.DataStore'

class RailsDataStore
	def store_categories(categories)
		puts "categories: #{categories.size}"
		categories.each do |category|
			puts category.name
		end
	end
end

class TestClient
	def do_test
		fetcher = DataFetcher.new
		fetcher.fetchCategories(RailsDataStore.new)
	end
end

TestClient.new.do_test