class AddDevelopersController < ApplicationController
  def new
  	@relation = Relation.new
  end

  def create
  	@relation = Relation.new(params_add_developer)
  	project = Project.find(@relation.project_id)
  	if @relation.valid? && @relation.assign_id != project.user_id
			@relation.save
			flash[:success] = "Add developer success"
			redirect_to "/users/#{project.user_id}"
  	else
			flash.now[:danger] = "This user is manager"
			render 'new'
  	end
  end

  private
  def params_add_developer
  	params.require(:relation).permit(:assign_id,:project_id)
  end
end
