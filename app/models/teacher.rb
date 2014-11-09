class Teacher < ActiveRecord::Base
  has_many :groups
  has_many :students, through: :groups
end
