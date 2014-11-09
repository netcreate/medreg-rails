class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :code, uniqueness: true

  has_and_belongs_to_many :groups, uniq: true

  def full_name
    [name, infix, surname].reject(&:blank?).join(' ')
  end

  def associate_group(group)
    self.groups << group unless self.groups.include?(group)
  end
end
