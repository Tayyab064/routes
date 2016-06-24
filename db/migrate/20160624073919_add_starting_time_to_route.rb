class AddStartingTimeToRoute < ActiveRecord::Migration
  def change
  	add_column :routes , :start_time , :time
  end
end
