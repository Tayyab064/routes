class AddLatLongToRouteHistroy < ActiveRecord::Migration
  def change
  	add_column :routes , :latitude , :float
  	add_column :routes , :longitude , :float

  	add_column :histroys , :latitude , :float
  	add_column :histroys , :longitude , :float
  end
end
