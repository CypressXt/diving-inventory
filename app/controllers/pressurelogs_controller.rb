class PressurelogsController < ApplicationController
  before_action :get_tank

  def new
    @pressure_log = Pressurelog.new
    @pressure_log.tank = @tank
    @is_filled = false
    last_pressure_log = @tank.pressurelogs.order("updated_at DESC").first
    if last_pressure_log.presence and
        last_pressure_log.pressure_start.presence and
        last_pressure_log.pressure_end == nil
      @is_filled = true
      @pressure_log = last_pressure_log
    end
  end

  def create
    @pressure_log = Pressurelog.new(pressure_log_params)
    @pressure_log.tank = @tank
    if @pressure_log.save
      flash[:success] = 'Current pressure successfully saved !'
      redirect_to tank_path(@tank)
    else
      render 'new'
    end
  end

  def update
    @pressure_log = Pressurelog.find(params[:id])
    if @pressure_log.update_attributes(pressure_log_params)
      flash[:success] = 'Current pressure successfully saved !'
      redirect_to tank_path(@tank)
    else
      render 'new'
    end
  end

  def pressure_log_params
    params.require(:pressurelog).permit(:tank_id, :pressure_start, :pressure_end)
  end

  private

    def get_tank
      @tank = Tank.find(params[:tank_id])
    end
end
