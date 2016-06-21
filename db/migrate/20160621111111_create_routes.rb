class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route_name
      t.time :estimated_time
      t.string :starting_point
      t.string :data_file

      t.timestamps null: false
    end
  end
end
