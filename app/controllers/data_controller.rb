class DataController < ApplicationController

  def index
    url = request.headers['url']
    response = RestClient.get(url)
    data = JSON.parse(response)

    render json: data, status: :ok
  end
end
