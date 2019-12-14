class DoorsController < ApplicationController
  def index
    doors = policy_scope(Door)

    render json: doors.as_json
  end

  def show
    door = policy_scope(Door).find(params[:id])

    render json: door.as_json
  end
end
