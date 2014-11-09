class CreateGroupsStudents < ActiveRecord::Migration
  def change
    create_table :groups_students do |t|
      t.belongs_to :student
      t.belongs_to :group
    end
  end
end
