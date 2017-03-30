class ProjectsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:create]
	def new
		@project = Project.new
	end
	def create
		@project = Project.new(params_project)
		@project.update_attribute(:user_id, current_user.id)
		if @project.save
			flash[:success] = "Create project success"
			render 'show'
		else
			render 'new'
		end
	end

	def show
			@project = Project.find(params[:id])
	end
	
	def new_issue
		@issue = Issue.new
		@project = Project.find(params[:id])
	end

	def create_issue
		@issue = Issue.new(params_issue)
		@project = Project.find(params[:id])
		if @issue.save
			flash[:success] = "Create issue success"
			render 'show_issue'
		else
			render 'new_issue'
		end
	end

	def show_issue_create
		@issue = Issue.find(params[:id])
	end

	def show_issue
		@project = Project.find(params[:id])
	end

	private
		def params_project
			params.require(:project).permit(:project_name, :description, :user_id)
		end

		def params_issue
			params.require(:issue).permit(:issue_name,:issue_decription,:assign_id,:project_id,:user_id,:start_date,:due_date)
		end
end
