class CreateGmanagers < ActiveRecord::Migration
  def change
    create_table :gmanagers do |t|
      t.string :id_group
      t.integer :
      t.string :id_owner
      t.integer :
      t.string :perm
      t.string :
      t.string :string
    end
  end
end
