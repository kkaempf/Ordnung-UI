#
# TagController
#
class TagController < ApplicationController
  # mark tag as active
  def activate
    session[:active_tag] = params[:name]
    logger.info "Activate #{session[:active_tag]}"
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
    begin
      tag = Tag.find_by(:name => session[:active_tag])
      begin
        item = Item.find(id)
        if (item.tag_ids.include? tag._id)
          item.tag_ids.delete(tag._id)
        else
          item.tags << tag
        end
        item.save
      rescue Mongoid::Errors::DocumentNotFound
        logger.error "Item id #{id} does not exist"
      end
    rescue Mongoid::Errors::DocumentNotFound
      logger.error "Tag '#{session[:active_tag]}' does not exist"
    end
    render :nothing => true
  end
end
