class StartingEquipmentController < ApplicationController

  def show
    resp = RestClient.get(request.headers["url"])
    @equipment = JSON.parse(resp)
    starting = @equipment["starting_equipment"]
    choices = []

    num_choices = @equipment["choices_to_make"]

    for i in 1..num_choices do
      choice = @equipment["choice_#{i}"]

      choice.each do |option|

        # if the number you can choose is the length of things you can choose from,
        # it is automatically put in the starting array
        if option["from"].length == option["choose"]
          starting += option["from"]

        # else put it in the array choices of to be made on the front end
        else
          choices.push(option)
        end
      end
    end

    render json: {starting: starting, choices: choices}
  end

end
