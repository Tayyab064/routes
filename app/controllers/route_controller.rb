class RouteController < ApplicationController
	before_action :authenticate_user!

	def index
		@rout = Route.all
	end

	def create

		if params[:route_name].present? && params[:file_upload].present?
			s_time = params[:starting_time] + " " + params[:time]
			p s_time
			@rout = Route.create(route_name: params[:route_name] , estimated_time: params[:estimated_time] , starting_point: params[:starting_point] , start_time: s_time)

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
					hist = Histroy.create(address: row.to_hash['address'] , route_id: @rout.id , delay: row.to_hash['delay'], comment: row.to_hash['comment'], starting_point: row.to_hash['starting_point'])
				end
			else
				p "Invalid file"
			end
		else
			redirect_to :root
		end
	end

	def show
		@route = Route.find(params[:id])
	end

	def edit
		@route = Route.find(params[:id])
	end

	def update
		p params
		@route = Route.find(params[:id])
		if params[:route][:delay].present?
			d_tim =  params[:route][:delay] + " " +  params[:tim_f]
			@route.update(delay: params[:route][:delay])
			p "Delay Added"
			redirect_to :back, notice: 'Route was successfully updated.'
		else
			s_time = params[:route][:start_time] + " " + params[:time]
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
			if xml_contents.present? && file_data.original_filename.split('.')[-1]=='csv'
				@csv = CSV.parse(xml_contents, :headers => true)
				@csv.each do |row|
					p row.to_hash
					hist = Histroy.create(address: row.to_hash['address'] , route_id: @route.id , delay: row.to_hash['delay'], comment: row.to_hash['comment'], starting_point: row.to_hash['starting_point'])
				end
			else
				p "Invalid file"
			end
			@route.update(start_time: s_time)
		    respond_to do |format|
		      if @route.update(route_update_params)
		        format.html { redirect_to route_path, notice: 'Route was successfully updated.' }
		        format.json { render :index, status: :updated, location: @route }
		      else
		        format.html { render :edit }
		        format.json { render json: @home.errors, status: :unprocessable_entity }   
		      end
		    end
		end
		
	end

	def destroy
		@route = Route.find(params[:id])
    	@route.destroy
  
    	redirect_to :back , notice: 'Route was successfully destroyed.'
	end

	def csvfile
		@route = Route.all
		respond_to do |format|
		    format.html
		    format.csv { send_data @route.to_csv }
		    format.xls { send_data @route.to_csv(col_sep: "\t") }
		end
	end

	def simplecsvfile
		@route = Route.where(id: params[:id])
		respond_to do |format|
		    format.html
		    format.csv { send_data @route.to_simp_csv }
		    format.xls { send_data @route.to_simp_csv(col_sep: "\t") }
		end
	end


	private

	def route_update_params
		params.require(:route).permit(:route_name , :starting_point , :estimated_time)
	end

end
