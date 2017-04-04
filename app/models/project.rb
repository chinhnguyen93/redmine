class Project < ApplicationRecord
	has_many :issues
	has_many :relations, dependent: :destroy
	has_many :users, :through => :relations
	validates :project_name, presence: true, length: { maximum: 30 }
	validates :description, presence: true, length: { maximum: 140}
end
