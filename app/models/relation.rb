class Relation < ApplicationRecord
	belongs_to :user, foreign_key: :assign_id
	belongs_to :project
end
