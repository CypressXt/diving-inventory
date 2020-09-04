class TanksController < ApplicationController
  before_action :must_be_logged, except: [:index, :show]
  before_action :must_be_admin, only: [:create, :qrcode, :destroy]

  def index
    @tanks = Tank.all.includes(:pressurelogs)
  end

  def new
    @tank = Tank.new
  end

  def create
    @tank = Tank.new(tank_params)
    if @tank.save
      flash[:success] = 'Tank #'+@tank.tank_number.to_s+' successfully created.'
      redirect_to tanks_path
    else
      render 'new'
    end
  end

  def show
    @tank = Tank.find(params["id"])
    last_pressure_log = @tank.pressurelogs.order("updated_at DESC").first
    @is_filled = false
    if last_pressure_log.presence and last_pressure_log.pressure_end == nil
      @is_filled = true
    end
    @pressure_diving_logs = @tank.pressurelogs.order("updated_at DESC")
  end

  def qrcode
    tank = Tank.find(params["tank_id"])
    qr_data = RQRCode::QRCode.new(url_for(tank))
    qrcode = qr_data.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 1000
    )
    render inline: '<img src="'+qrcode.to_data_url+'"/>'.html_safe
  end

  def delete
    @tank = Tank.find(params["tank_id"])
  end

  def destroy
    @tank = Tank.find(params["id"])
    if @tank.destroy
      flash[:success] = 'Tank #'+@tank.tank_number.to_s+' removed !'
      redirect_to tanks_path
    else
      flash[:danger] = 'Failed to remove the tank #' + @tank.tank_number
      redirect_to tank_path(@tank)
    end
  end

  def tank_params
    params.require(:tank).permit(:tank_number, :volume)
  end
end
