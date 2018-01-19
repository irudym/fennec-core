class V1::DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy, :restore]

  # GET /devices
  def index
    @devices = Device.available
    json_response @devices
  end

  # POST /devices
  def create
    @device = Device.create!(device_params)
    json_response(@device, :created)
  end

  # GET /devices/:id
  def show
    json_response(@device)
  end

  # PUT /devices/:id
  def update
    @device.update(device_params)
    head :no_content
  end

  # DELETE /devices/:id
  def destroy
    @device.put_to_trash
    head :no_content
  end

  # GET /devices/trash
  def trash
    @devices = Device.trash_bin
    json_response @devices
  end

  # PUT /devices/trash/:id - restore device
  def restore
    @device.restore
    head :no_content
  end

  # GET /devices/pages - provide paginated access to list of devices is sake of speed and traffic
  def pages
    index = params[:id].to_i
    @devices = Device.to_pages(index)
    json_response @devices
  end

  def trash_pages
    index = params[:id].to_i
    @devices = Device.to_trash_pages(index)
    json_response @devices
  end

  private

  def device_params
    params.permit(:name, :MAC, :description)
  end

  def set_device
    @device = Device.find(params[:id])
  end
end
