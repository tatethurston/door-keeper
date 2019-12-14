class CodesController < ApplicationController
  def index
    codes = policy_scope(Code)

    render json: codes.as_json
  end

  def show
    code = policy_scope(Code).find(params[:id])

    render json: code.as_json
  end
end
