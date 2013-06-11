require 'java'

java_import 'at.dinauer.fhbay.util.DataFetcher'

class RailsDataStore
  attr_reader :articles

  def store_articles(articles)
    @articles = articles
  end
end

class ArticlesController < ApplicationController
  def index
    fetcher = DataFetcher.new
    dataStore = RailsDataStore.new

    fetcher.fetch_all_articles(dataStore)
    @articles = dataStore.articles
  end
end
