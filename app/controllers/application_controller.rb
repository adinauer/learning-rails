require 'java'

java_import 'at.dinauer.fhbay.util.DataFetcher'
java_import 'at.dinauer.fhbay.util.PropertyBasedDataStore'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_categories

  def find_categories
    fetcher = DataFetcher.new
    dataStore = PropertyBasedDataStore.new
    fetcher.fetchCategories(dataStore)

    @categories = dataStore.categories
  end
end
