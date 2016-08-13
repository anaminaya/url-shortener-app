class LinksController < ApplicationController

  def index
    @links = Links.all
    end

  def create
    @links = Links.create(
    slug:params[:slug],
    target_url:params[:target_url],
    )

    if @links.valid?
    flash[:success]= "Link successfully created"
    redirect_to action: "index"
    else
      flash[:danger]= @links.errors.full_messages
      render "new.html.erb"
    end
  end








end
