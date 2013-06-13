FHBay Rails Client
==================

Prerequisites
-------------

* JBoss with FHBay running (github.com/adinauer/fhbay)
* MySql with fhbay database running
* JRuby for running the rails client which communicates with JBoss

Running
-------

	rails s


How does the communication with JBoss work?
-------------------------------------------

Two different methods evaluated:
* Remote EJB Client (JNDI)
* REST (JSON)

### Remote EJB Client

The following Java-Libraries have to be placed in the lib/java directory of the rails application:
* fhbay-commons.jar
* fhbay-client-commons.jar
* hibernate-core-4.1.9.Final.jar
* jboss-client.jar

These libraries have to be included in config/application.rb:

	require 'lib/java/fhbay-commons.jar'
	require 'lib/java/fhbay-client-commons.jar'
	require 'lib/java/jboss-client.jar'
	require 'lib/java/hibernate-core-4.1.9.Final.jar'

To communicate the controller has to be modified:

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
	end

### REST

The required gems have to be added to the Gemfile:

	gem 'rest-client'
	gem 'json'

To communicate the controller has to be modified:

	require 'rest_client'
	require 'json'

	class ArticlesController < ApplicationController
	  def bid_history
	    article_id = params[:articleId]

	    json = RestClient.get "http://localhost:8080/fhbay-web/api/bidHistory/#{article_id}"
	    @bids = JSON.parse(json)

	    render 'articles/bid_history'
	  end

	  def place_bid
	    customerId = 16
	    response = RestClient.post 'http://localhost:8080/fhbay-web/api/placeBid', { 'articleId' => params[:articleId], 'customerId' => customerId, 'amount' => params[:amount] }.to_json, :content_type => :json, :accept => :json

	    puts response

	    redirect_to :back
	  end
	end

