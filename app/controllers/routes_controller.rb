class RoutesController < ApplicationController
  def new
  end

  def create
    @route = Route.new params[:route]

    if @route.save
      redirect_to @route
    else
      flash[:failure] = 'Failed to create route'
      render :action => 'new'
    end
  end
end
