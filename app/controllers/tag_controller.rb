#
# TagController
#
class TagController < ApplicationController
  def activate
    name,value = params[:name].split("=")
    tag = Tag.find_by(:name => name, :value => value)
    session[:active_tag] = tag._id.to_s
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
end
