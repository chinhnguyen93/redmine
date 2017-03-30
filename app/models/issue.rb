class Issue < ApplicationRecord
	belongs_to :user
	belongs_to :project
	validates :issue_name, presence: true
	validates :issue_decription, presence: true
	validates :assign_id, presence: true
	validates :start_date, presence: true
	validates :due_date, presence: true
end
