class JobsController < ApplicationController

  def index
    @jobs = Job.all
    render json: @jobs
  end

  def show
    @job = Job.find_by(id: params[:id])
    render json: @job.show_format
  end
end
