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
    Tag.find_or_create_by(:name => name, :value => value)
    render :nothing => true
  end
end
