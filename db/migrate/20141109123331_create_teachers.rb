class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :code
      t.string :name
      t.string :infix
      t.string :surname
      t.timestamps
    end
  end
end
