class DirSelectorController < ApplicationController
  def index
    @dir = params[:dir] || "/"
  end

end
