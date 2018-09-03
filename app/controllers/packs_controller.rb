class PacksController < ApplicationController

  def show
    urls = request.headers["urls"].split(",")
    items = []
    urls.each do |url|
      resp = RestClient.get(url)
      item = JSON.parse(resp)
      items << item
    end
    
    render json: { items: items }
  end

end
