class ResizeController < ApplicationController
  def resize
    session[:width] = w = params[:width]
    session[:height] = h = params[:height]
    session[:zoom] = z = params[:zoom]
    logger.info "H #{h}, W #{w}, Z #{z}"
    render :nothing => true
  end
end
