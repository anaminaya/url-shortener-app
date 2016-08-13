class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @links = Link.where(user_id: current_user.id)
    else
      render "index.html.erb"
    end
  end

  def create
    @link = Links.create(
    slug:params[:slug],
    target_url:params[:target_url],
    )

    if @link.valid?
    flash[:success]= "Link successfully created"
    redirect_to action: "index"
    else
      flash[:danger]= @link.errors.full_messages
      render "new.html.erb"
    end
  end

  def new
    render "new.html.erb"
  end

  def standardize_target_url!
    target_url.gsub!("http://", "")
    target_url.gsub!("https://", "")
  end

  def show
    unless @link = Link.find_by(id: params[:id])
      not_found
    end
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = Link.find_by(id: params[:id])
    @link.update(
    slug:params[:slug],
    target_url:params[:target_url],
    )


    if @link.valid?
      flash[:success]= "Link successfully updated"
      redirect_to "/link/#{@link.id}"
    else
      flash[:danger]= @link.errors.full_messages
      render "edit.html.erb"
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id])
    @link.destroy
    flash[:danger]= " Link was successfully destroyed"
    redirect_to '/link'
  end







end
