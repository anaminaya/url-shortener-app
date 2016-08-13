class VisitsController < ApplicationController
  def create
    @link = Link.find_by(slug: params[:slug])

    @link.create(
    link_id: @link.id,
    ip_address: request.remote_ip
    )
  end





end
