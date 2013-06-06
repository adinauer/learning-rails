class ClientsController < ApplicationController
  def index
    puts "blablub"
    @testBla = "lorem ipsum dolor sit amet"
    @para = params
  end
end
