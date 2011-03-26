#
# RESTful controller for Items
#
class ItemsController < ApplicationController
  def new
  end
  
  def create
    puts params
    redirect_to "/"
  end
end
