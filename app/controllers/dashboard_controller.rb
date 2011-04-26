class DashboardController < ApplicationController
  def home
    @items = Item.all
  end

  def login
  end

  def logout
  end

end
