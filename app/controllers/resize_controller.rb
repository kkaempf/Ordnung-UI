class ResizeController < ApplicationController
  def resize
    session[:width] = w = params[:width]
    session[:height] = h = params[:height]
    z = params[:zoom]
    if z == "0"
      z = session[:zoom]
      puts "Session Z #{z.inspect}"
    else
      session[:zoom] = z
      puts "JS Z #{z.inspect}"
    end
    logger.info "H #{h}, W #{w}, Z #{z}"
    render :json => { :zoom => z.to_i }
  end
end
