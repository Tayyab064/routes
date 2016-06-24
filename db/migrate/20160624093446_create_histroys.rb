class CreateHistroys < ActiveRecord::Migration
  def change
    create_table :histroys do |t|
      t.string :address
      t.integer :route_id
      
      t.timestamps null: false
    end
  end
end
