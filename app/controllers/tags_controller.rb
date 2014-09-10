#
# TagsController
#
class TagsController < ApplicationController
  # show tag cloud
  def home
    if session[:active_tags]
      @active = session[:active_tags].split(",")
    end
    render :partial => 'home'
  end
  # mark tag as active
  def activate
    tags = session[:active_tags];
    if tags && !tags.empty?
      tags << ",#{params[:name]}"
    else
      tags = params[:name]
    end
    session[:active_tags] = tags
    logger.info "Active #{session[:active_tags]}"
    render :nothing => true
  end
  def deactivate
    if session[:active_tags]
      tags = session[:active_tags].split(",")
      tags.delete(params[:name])
      session[:active_tags] = tags.join(",")
      logger.info "New active #{session[:active_tags]}"
    end
    render :nothing => true
  end
  # add new tag
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
  # remove tag
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
  # change active tag in item
  def item
    id = BSON::ObjectId.from_string(params[:id])
    tags = []
    session[:active_tags].split(",").each do |tag|
      begin
        name,value = tag.split("=")
        tags = Tag.find_by(:name => name, :value => value)
      rescue Mongoid::Errors::DocumentNotFound
        logger.error "Active tag '#{tag}' does not exist"
      end
    end
    begin
      item = Item.find(id)
      tags.each do |tag|
        if (item.tag_ids.include? tag._id)
          item.tag_ids.delete(tag._id)
        else
          item.tags << tag
        end
      end
      item.save
    rescue Mongoid::Errors::DocumentNotFound
      logger.error "Item id #{id} does not exist"
    end
    render :nothing => true
  end
end
