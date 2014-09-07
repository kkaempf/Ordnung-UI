class DashboardController < ApplicationController
  def home
  end

  def redraw
    @zoom = (session[:zoom] ||= "100").to_i
    @width = session[:width].to_i
    @height = session[:height].to_i
    @item_width = @zoom # (session[:item_width] ||= "100").to_i
    @item_height = @zoom # (session[:item_height] ||= "100").to_i
    @item_margin = 3
    # calculate item count horizontal and vertical
    @item_horizontal = @item_width + 2*@item_margin
    @items_per_row = @width / @item_horizontal
    @items_per_row = 1 if @items_per_row < 1
    @item_vertical = @item_height + 2*@item_margin
    @items_per_col = @height / @item_vertical
    @items_per_col = 1 if @items_per_col < 1
    logger.info "#{@item_horizontal} per item horizontal, #{@items_per_row} items per row"
    logger.info "#{@item_vertical} per item vertical, #{@items_per_col} items per col"
    render :partial => "redraw"
  end

  def right
  end

  def login
  end

  def logout
  end

end
