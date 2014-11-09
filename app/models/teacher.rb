class Teacher < ActiveRecord::Base
  validates :name, presence: true
  validates :code, uniqueness: true

  has_many :groups
  has_many :students, through: :groups

  def full_name
    [name, infix, surname].reject(&:blank?).join(' ')
  end
end
