class RouteController < ApplicationController
	before_action :authenticate_user!

	def index
		@rout = Route.all
	end

	def create
		rout = Route.create(route_name: params[:route_name] , estimated_time: params[:estimated_time] , starting_point: params[:starting_point])
		redirect_to :root
	end

end
