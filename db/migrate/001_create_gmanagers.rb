class CreateGmanagers < ActiveRecord::Migration
  def change
    create_table :gmanagers do |t|
      t.integer :id_group
      t.integer :id_owner
      t.string :perm
      
    end
  end
end
