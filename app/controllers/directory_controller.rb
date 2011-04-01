class DirectoryController < ApplicationController
  def index
    @dir = params[:dir] || "/"
  end

end
