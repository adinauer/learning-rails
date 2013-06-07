class ClientsController < ApplicationController
  def index
    puts "blablub"
    @test_bla = "lorem ipsum dolor sit amet"
    @para = params

    # redirect_to root_url
    # redirect_to statuses_url
  end
end
