require 'java'

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

class ClientsController < ApplicationController
  def index
    puts "blablub"
    @test_bla = "lorem ipsum dolor sit amet"
    @para = params

    # redirect_to root_url
    # redirect_to statuses_url

    @article = PmodArticle.new
    @article.name = "Canon EOS 6D"

    fetcher = DataFetcher.new
    fetcher.fetchCategories(RailsDataStore.new)

    @java_version = System.getProperties["java.runtime.version"]
  end
end
