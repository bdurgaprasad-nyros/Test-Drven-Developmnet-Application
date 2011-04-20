class PhotoController < ApplicationController
  before_filter :authenticate_user!

  def new_photo_iframe
    @this_object_id = params[:object_id]
    @this_model = params[:model]
    @mounted_as = params[:mounted_as]
  end
  
  def new_photo_form
    @came_from = params[:came_from]
    @this_object_id = params[:object_id]
    @this_model = params[:model]
    @mounted_as = params[:mounted_as]
    @photo = @this_model.classify.constantize.find(@this_object_id).send("#{@mounted_as}_url")
    render :layout=>false
  end

  def set_image
    @redirect_path = params[:redirect_path]
    @came_from = params[:came_from]
    @this_object_id = params[:object_id]
    @this_model = params[:model]
    @mounted_as = params[:mounted_as]
    @object=@this_model.classify.constantize.find(@this_object_id.to_i)
    @object.send(:attributes=, { @mounted_as.to_sym => params[:file]}, false)

    if (params[:preview] == "1" ? @object.valid? : @object.save)
      @object.copy_avatar_to_group if @came_from == "registrations"
      render :text => @object.avatar.url
    else
      if @came_from == "registrations"
        render :action => "new_photo_form", :layout => false
      elsif @came_from == "/profile/image"
        render :partial => "profile/image"
      end
    end
  end
end
