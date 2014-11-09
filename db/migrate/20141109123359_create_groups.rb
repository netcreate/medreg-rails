class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :teacher
      t.string :code
      t.string :type
      t.string :description
      t.timestamps
    end
  end
end
