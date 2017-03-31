class ProjectsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:create]
	def new
		@project = Project.new
	end
	def create
		@project = Project.new(params_project)
		if @project.valid?
			flash.now[:success] = "Create project success"
			@project.save
			redirect_to "/projects/#{@project.id}"
		else
			render 'new'
		end
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(params_project)
			flash.now[:success] = "Your project is successfull updated"
			render 'show'
		else
			flash.now[:danger] = "Project update fail"
			render 'edit'
		end
	end
	
	def destroy
		project = Project.find(params[:id])
		project.destroy
		flash.now[:success] = "Project deleted"
		redirect_to "/users/#{project.user.id}"
	end

	def new_issue
		@issue = Issue.new
		@project = Project.find(params[:id])
	end

	def create_issue
		@project = Project.find(params[:id])
		@issue = Issue.new(params_issue)
		if @issue.save
			flash.now[:success] = "Create issue success"
			render 'show_issue'
		else
			render 'new_issue'
		end
	end

	def show_issue_create
		@issue = Issue.find(params[:iid])
		@project = Project.find(params[:id])
	end

	def show_issue
		@project = Project.find(params[:id])
	end

	def edit_issue
		@project = Project.find(params[:id])
		@issue = Issue.find(params[:iid])
	end

	def update_issue
		@project = Project.find(params[:id])
		@issue = Issue.find(params[:iid])
		if @issue.update_attributes(params_issue)
			flash.now[:success] = "Your issue is successfull updated"
			render 'show_issue_create'
		else
			flash.now[:danger] = "Issue update fail"
			render 'edit_issue'
		end
	end

	def destroy_issue
		issue = Issue.find(params[:iid])
		issue.destroy
		flash.now[:success] = "Issue deleted"
		redirect_to "/projects/#{issue.project_id}/show_issue"
	end
	private
		def params_project
			params.require(:project).permit(:project_name, :description, :user_id)
		end

		def params_issue
			params.require(:issue).permit(:issue_name,:issue_decription,:assign_id,:project_id,:user_id,:start_date,:due_date)
		end
end
