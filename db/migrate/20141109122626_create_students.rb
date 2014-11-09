class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :code
      t.string :name
      t.string :infix
      t.string :surname
      t.string :password
      t.timestamps
    end
  end
end
