class Student < ActiveRecord::Base
  validates :name, presence: true
  validates :code, uniqueness: true
  self.per_page = 100

  has_attached_file :picture, :styles => {
    :thumb => "100x140>"
  }, :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  has_and_belongs_to_many :groups, uniq: true

  def full_name
    [name, infix, surname].reject(&:blank?).join(' ')
  end

  def associate_group(group)
    self.groups << group unless self.groups.include?(group)
  end
end
