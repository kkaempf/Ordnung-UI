class DashboardController < ApplicationController
  def home
    @items = Item.find
  end

  def login
  end

  def logout
  end

end
