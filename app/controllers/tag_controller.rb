#
# TagController
#
class TagController < ApplicationController
  def activate
    session[:active_tag] = params[:name]
    logger.info "Activate #{session[:active_tag]}"
    render :nothing => true
  end
  def add
    name,value = params[:name].split("=")
    begin
      Tag.find_by(:name => name, :value => value)
      render({ :nothing => true })
    rescue Mongoid::Errors::DocumentNotFound
      Tag.create(:name => name, :value => value)
      render :json => { :html => "<span class='tag'>#{params[:name]}</span>" }
    end
  end
  def remove
  end
end
