require 'java'

java_import 'at.dinauer.fhbay.util.DataFetcher'
java_import 'at.dinauer.fhbay.util.PropertyBasedDataStore'

class ArticlesController < ApplicationController
  def index
    fetcher = DataFetcher.new
    dataStore = PropertyBasedDataStore.new

    fetcher.fetch_all_articles(dataStore)
    @articles = dataStore.articles
  end

  def by_category
    fetcher = DataFetcher.new
    dataStore = PropertyBasedDataStore.new

    fetcher.fetch_articles_by_category(dataStore, params[:category_id])
    @articles = dataStore.articles

    render 'articles/index'
  end

  def details
    fetcher = DataFetcher.new
    dataStore = PropertyBasedDataStore.new

    fetcher.fetch_article_by_id(dataStore, params[:article_id])
    @selected_article = dataStore.selected_article
  end
end
