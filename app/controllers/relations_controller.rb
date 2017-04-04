class RelationsController < ApplicationController
	def new
		@relation = Relation.new
	end
end
