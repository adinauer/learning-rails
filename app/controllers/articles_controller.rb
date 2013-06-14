require 'java'
require 'rest_client'
require 'json'

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

  def bid_history
    article_id = params[:articleId]

    fetcher = DataFetcher.new
    dataStore = PropertyBasedDataStore.new

    fetcher.fetch_article_by_id(dataStore, article_id)
    @selected_article = dataStore.selected_article

    json = RestClient.get "http://localhost:8080/fhbay-web/api/bidHistory/#{article_id}"
    @bids = JSON.parse(json)

    render 'articles/bid_history'
  end

  def place_bid
    customerId = 16
    bid_status = RestClient.post 'http://localhost:8080/fhbay-web/api/placeBid', { 'articleId' => params[:articleId], 'customerId' => customerId, 'amount' => params[:amount] }.to_json, :content_type => :json, :accept => :json
    bid_status = bid_status.gsub!(/\A"|"\Z/, '')

    20.times { puts '*'}
    puts "<#{bid_status == '"ACCEPTED"'}>"

    if bid_status == 'ACCEPTED'
      redirect_to :back, :notice => 'Bid successfuly placed.'
    else
      redirect_to :back, :alert => "Unable to place bid: #{bid_status}"
    end
  end
end
