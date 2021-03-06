class RoutesController < ApplicationController
  def new
    @route = Route.new
  end

  def create
    @route = Route.new params[:route]

    if @route.save
      render :action => 'create'
    else
      logger.debug "Failed to create route. Errors: #{@route.errors.full_messages.inspect}"
      render :action => 'new'
    end
  end
end
