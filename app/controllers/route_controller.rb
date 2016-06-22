class RouteController < ApplicationController
	before_action :authenticate_user!

	def index
		@rout = Route.all
	end

	def create

		if params[:route_name].present? && params[:file_upload].present?
			@rout = Route.create(route_name: params[:route_name] , estimated_time: params[:estimated_time] , starting_point: params[:starting_point])

			file_data = params[:file_upload]
			if file_data.respond_to?(:read)
			  xml_contents = file_data.read
			  p "read"
			elsif file_data.respond_to?(:path)
			  xml_contents = File.read(file_data.path)
			  p "path"
			else
			  logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
			end
			p file_data.original_filename.split('.')[-1]
			if xml_contents.present? && file_data.original_filename.split('.')[-1]=='csv'
				@csv = CSV.parse(xml_contents, :headers => true)
				@csv.each do |row|
					p row.to_hash
				end
			else
				p "Invalid file"
			end
		else
			redirect_to :root
		end
	end

end