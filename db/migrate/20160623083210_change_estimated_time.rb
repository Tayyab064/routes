class ChangeEstimatedTime < ActiveRecord::Migration
  def change
  	remove_column :routes , :estimated_time
  	add_column :routes , :estimated_time , :string
  end
end
