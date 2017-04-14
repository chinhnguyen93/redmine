class ProjectsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:create]
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :correct_user_issue, only: [:edit_issue, :update_issue, :destroy_issue]
	def new
		@project = Project.new
		@user = User.find(params[:id])
	end
	def create
		@project = Project.new(params_project)
		user = User.find(@project.user_id)
		pro = Project.first
		if @project.valid?
			flash.now[:success] = "Create project success"
			@project.save
			@relation = Relation.create(assign_id: @project.user_id, project_id: @project.id)
			redirect_to pro
		else
			render 'new'
		end
	end

	def show
		@project = Project.find(params[:iid])
	end

	def edit
		@project = Project.find(params[:iid])
	end

	def update
		@project = Project.find(params[:iid])
		if @project.update_attributes(params_project_edit)
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
		flash[:success] = "Project deleted"
		redirect_to current_user
	end

	def new_issue
		@issue = Issue.new
		@project = Project.find(params[:iid])
	end

	def create_issue
		@project = Project.find(params[:iid])
		@issue = Issue.new(params_issue)
		if @issue.save
			flash[:success] = "Create issue success"
			redirect_to "/projects/#{@project.id}/show_issue"
		else
			redirect_to "/projects/#{@project.id}/new_issue"
		end
	end

	def show_issue_create
		@issue = Issue.find(params[:id])
		@project = Project.find(params[:iid])
	end

	def show_issue
		@project = Project.find(params[:iid])
	end

	def edit_issue
		@project = Project.find(params[:iid])
		@issue = Issue.find(params[:id])
	end

	def update_issue
		@project = Project.find(params[:iid])
		@issue = Issue.find(params[:id])
		if @issue.update_attributes(params_issue)
			flash.now[:success] = "Your issue is successfull updated"
			render 'show_issue_create'
		else
			flash.now[:danger] = "Issue update fail"
			render 'edit_issue'
		end
	end

	def destroy_issue
		issue = Issue.find(params[:id])
		issue.destroy
		flash.now[:success] = "Issue deleted"
		project = Project.find(issue.project_id)
		user = User.find(current_user.id)
		redirect_to "/projects/#{issue.project_id}/show_issue"
	end

	def correct_user
		project = Project.find(params[:id])
		user = User.find(project.user_id)
    return true if current_user == user
    flash[:danger] = "You cant edit another user"
    redirect_to root_url
  end

  def correct_user_issue
  	issue = Issue.find(params[:id])
  	return true if current_user.id == issue.user_id
  	flash[:danger] = "You are not issue of manager"
  	redirect_to "/projects/#{issue.project_id}/show_issue"
  end

	private
		def params_project
			params.require(:project).permit(:project_name,:description,:user_id)
		end
		def params_project_edit
			params.require(:project).permit(:project_name,:description)
		end
		def params_issue
			params.require(:issue).permit(:issue_name,:issue_decription,:assign_id,:project_id,:user_id,:start_date,:due_date)
		end
end
