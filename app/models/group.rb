class Group < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true

  belongs_to :teacher
  has_and_belongs_to_many :students, uniq: true

  self.inheritance_column = nil
end
