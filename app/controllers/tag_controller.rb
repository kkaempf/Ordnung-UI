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
    name,value = params[:name].split("=")
    begin
      tag = Tag.find_by(:name => name, :value => value)
      items = Item.any_in(:tag_ids => [tag._id])
      logger.info "Items with #{params[:name]}: #{items.count}"
      items.each do |item|
        item.tag_ids.delete(tag._id)
        item.save
      end
      tag.destroy
    rescue Mongoid::Errors::DocumentNotFound
    end
    render :nothing => true
  end
end
