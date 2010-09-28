class JobsController < ApplicationController
  def index
    @jobs = Job.paginate :page => params[:page], :order => "id desc"
  end
end
