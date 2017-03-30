class Project < ApplicationRecord
	belongs_to :user
	has_many :issues
	validates :project_name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensetive: false }
	validates :description, presence: true, length: { maximum: 140}
end
