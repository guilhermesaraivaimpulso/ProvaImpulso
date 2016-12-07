class LogsController < ApplicationController
  def matlogs
    @logs = Log.where(material: log_params[:matid])
  end
  private
    def log_params
      params.require(:material).permit(:matid)
    end
end