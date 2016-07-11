class AddDelayToRoute < ActiveRecord::Migration
  def change
  	add_column :routes , :delay , :string
  end
end
