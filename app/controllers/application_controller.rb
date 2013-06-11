require 'java'

java_import 'at.dinauer.fhbay.util.DataFetcher'

class RailsDataStore
  attr_reader :categories

  def store_categories(categories)
    puts "categories: #{categories.size}"
    categories.each do |category|
      puts category.name
    end

    @categories = categories
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_categories

  def find_categories
    fetcher = DataFetcher.new
    dataStore = RailsDataStore.new
    fetcher.fetchCategories(dataStore)

    @categories = dataStore.categories
  end
end
