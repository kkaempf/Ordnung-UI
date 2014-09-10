class DashboardController < ApplicationController
  private
  def _page_calculate
    @zoom = session[:zoom].to_i
    @width = session[:width].to_i
    @height = session[:height].to_i
    @page = session[:page].to_i
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
    @items_per_page = @items_per_row * @items_per_col
    logger.info "Page #{@page} #{@width}x#{@height}@#{@zoom}, #{@items_per_page} items per page"
    logger.info "#{@item_horizontal} per item horizontal, #{@items_per_row} items per row"
    logger.info "#{@item_vertical} per item vertical, #{@items_per_col} items per col"
  end
  def _page_count
    _page_calculate
    count = Item.count / @items_per_page
    logger.info "#{count} pages"
    count
  end
  public
  def home
    session[:zoom] ||= "100"
    session[:page] ||= "1"
    logger.info "Zoom #{session[:zoom].inspect}"
  end

  def redraw
    filter = Item
    if session[:active_tags]
      active = session[:active_tags].split(",")
      tag_ids = []
      begin
        active.each do |name|
          name,value = name.split("=")
          tag = Tag.find_by(:name => name, :value => value)
          tag_ids << tag._id
        end
        filter = Item.all_in(:tag_ids => tag_ids)
      rescue Mongoid::Errors::DocumentNotFound
      end
    end
    _page_calculate
    @items = filter.skip((@page-1) * @items_per_page).limit(@items_per_page)
    render :partial => "redraw"
  end

  def right
  end

  def first_page
    if session[:page] != "1"
      session[:page] = "1"
      redraw and return
    end
    render :json => nil
  end
  def last_page
    count = _page_count.to_s
    if session[:page] != count
      session[:page] = count
      redraw and return
    end
    render :json => nil
  end
  def next_page
    page = session[:page].to_i + 1
    if page <= _page_count
      session[:page] = page
      redraw and return
    end
    render :json => nil
  end
  def previous_page
    page = session[:page].to_i - 1
    if page > 0
      session[:page] = page
      redraw and return
    end
    render :json => nil
  end

  def login
  end

  def logout
  end

end
