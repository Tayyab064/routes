class AddColumnToHistory < ActiveRecord::Migration
  def change
  	add_column :histroys , :delay , :string
  	add_column :histroys , :comment , :string
  	add_column :histroys , :starting_point , :string
  end
end
