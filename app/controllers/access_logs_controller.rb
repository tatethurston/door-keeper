class AccessLogsController < ApplicationController
  def index
    access_logss = policy_scope(AccessLog)

    render access_logss.as_json
  end

  def show
    access_logs = policy_scope(AccessLog).find(params[:id])

    render access_logs.as_json
  end
end
