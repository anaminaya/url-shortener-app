class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @links = Link.where(user_id: current_user.id)
    end
    render "index.html.erb"
  end

  def create
    @link = Links.create(
    slug:params[:slug],
    target_url:params[:target_url],
    )
    @link.standardize_target_url!

    if @link.valid?
    flash[:success]= "Link successfully created"
    redirect_to '/links'
    else
      flash[:danger]= @link.errors.full_messages
      render "new.html.erb"
    end
  end

  def new
    @link = Link.new
    render "new.html.erb"
  end


  def show
    @link = Link.find_by(id: params[:id])

    unless @link
      not_found
      redirect_to '/links'
    end

  end

  def edit
    @link = Link.find_by(id: params[:id], user_id: current_user.id)
  end

  def update
    @link = Link.find_by(id: params[:id], user_id: current_user.id)
    @link.update(
    slug:params[:slug],
    target_url:params[:target_url],
    )
    @link.standardize_target_url!


    if @link.valid?
      flash[:success]= "Link successfully updated"
      redirect_to "/links/#{@link.id}"
    else
      flash[:danger]= @link.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id], user_id: current_user.id)
    @link.destroy
    flash[:danger]= " Link was successfully destroyed"
    redirect_to '/links'
  end

end
