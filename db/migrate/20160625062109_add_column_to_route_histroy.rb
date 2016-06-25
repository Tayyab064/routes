class AddColumnToRouteHistroy < ActiveRecord::Migration
  def change
  	remove_column :routes , :start_time
  	add_column :routes , :start_time , :string , default: ""
  end
end
