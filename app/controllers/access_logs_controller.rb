class AccessLogsController < ApplicationController
  def index
    access_logs = policy_scope(AccessLog)
      .includes(:door, :code)
      .order(created_at: :desc)
      .limit(50)

    render json: access_logs.as_json(include: [:door, :code])
  end

  def show
    access_log = policy_scope(AccessLog).find(params[:id])
      .includes(:door, :code)

    render json: access_log.as_json(include: [:door, :code])
  end
end
