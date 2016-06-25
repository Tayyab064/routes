class Route < ActiveRecord::Base
	has_many :histroys

	geocoded_by :starting_point   # can also be an IP address
	after_validation :geocode
	
	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |route|
	      csv << route.attributes.values_at(*column_names)
	    end
	  end
	end

	def self.to_simp_csv(options = {})
		CSV.generate(options) do |csv|
		  csv << column_names 
		  all.each do |route|
		    csv << route.attributes.values_at(*column_names)
		  end
		end
	end
end