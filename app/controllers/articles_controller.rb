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

  def by_category
    fetcher = DataFetcher.new
    dataStore = RailsDataStore.new

    fetcher.fetch_articles_by_category(dataStore, params[:category_id])
    @articles = dataStore.articles

    render 'articles/index'
  end
end
