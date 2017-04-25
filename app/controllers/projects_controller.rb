class ProjectsController < ApplicationController
  include ActionView::Helpers::DateHelper
	skip_before_filter :verify_authenticity_token
	before_action :correct_user, only: [:edit, :update, :destroy]
	# before_action :correct_user_issue, only: [:edit_issue, :update_issue, :destroy_issue]
	def new
		@project = Project.new
		@user = User.find(params[:id])
	end
	def create
		@project = Project.new(params_project)
		user = User.find(@project.user_id)
		if @project.valid?
			flash.now[:success] = "Create project success"
			@project.save
			@relation = Relation.create(assign_id: @project.user_id, project_id: @project.id)
			redirect_to @project
		else
			render 'new'
		end
	end

	def show
		@project = Project.find_by(id: params[:iid])
			if !@project
				flash[:danger] = "Nothing"
				redirect_to root_url
			else
			end
	end

	def edit
		@project = Project.find_by(id: params[:id])
	end

	def update
		@project = Project.find_by(id: params[:id])
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
		@status = ['New', 'Inprogress', 'Resolved', 'Closed']
		@priority = ['Low','Normal','Hight','Urgent','Immediate']
		@rela = Relation.where(project_id: @project.id)
		@assign = []
		@rela.each.with_index do |rela,i|
      @assign[i] = User.find_by(id: rela.assign_id)
    end
	end

	def create_issue
		@project = Project.find(params[:iid])
		@issue = Issue.new(params_issue)
		if @issue.save
			Log.create(issue_id: @issue.id,creator_id: current_user.id,log_status: @issue.status,log_priority: @issue.priority)
			flash[:success] = "Create issue success"
			redirect_to "/projects/#{@project.id}/show_issue"
		else
			redirect_to "/projects/#{@project.id}/new_issue"
		end
	end

	def show_issue_create
		@issue = Issue.find(params[:id])
		@user = User.find(@issue.user_id)
		@project = Project.find(params[:iid])
    @log = Log.where(issue_id: @issue.id)
    @update = []
    @status = []
    @priority = []
    for i in 0...@log.count
      issue = Issue.find(@log[i].issue_id)
      creator = User.find_by(id: @log[i].creator_id)
      update_by = User.find_by(id: @log[i].update_by)
      tim = distance_of_time_in_words(@log[i].updated_at.time, Time.now)
      if i == 0
        @create = "<strong>Created</strong> by #{creator.account} #{tim} ago"
      else
        if @log[i-1].log_status != @log[i].log_status && @log[i-1].log_priority != @log[i].log_priority
          @update[i] = "<strong>Updated</strong> by #{update_by.account} #{tim} ago"
          @status[i] = "<strong>Status</strong> changed from <strong>#{@log[i-1].log_status}</strong> to <strong>#{@log[i].log_status}</strong>"
          @priority[i] = "<strong>Priority</strong> changed from <strong>#{@log[i-1].log_priority}</strong> to <strong>#{@log[i].log_priority}</strong>"

        elsif @log[i-1].log_status != @log[i].log_status
          @update[i] = "<strong>Updated</strong> by #{update_by.account} #{tim} ago"
          @status[i] = "<strong>Status</strong> changed from <strong>#{@log[i-1].log_status}</strong> to <strong>#{@log[i].log_status}</strong>"

        elsif @log[i-1].log_priority != @log[i].log_priority
          @update[i] = "<strong>Updated</strong> by #{update_by.account} #{tim} ago"
          @priority[i] = "<strong>Priority</strong> changed from <strong>#{@log[i-1].log_priority}</strong> to <strong>#{@log[i].log_priority}</strong>"

        else
        end
      end
    end
	end

	def show_issue
		@project = Project.find(params[:iid])
	end

	def edit_issue
		@project = Project.find(params[:iid])
		@issue = Issue.find(params[:id])
		@user = User.find(@issue.user_id)
		@current_assign = User.find_by(id: @issue.assign_id)
		@status = ['New', 'Inprogress', 'Resolved', 'Closed']
		@priority = ['Low','Normal','Hight','Urgent','Immediate']
		@rela = Relation.where(project_id: @project.id)
		@assign = []
		@rela.each.with_index do |rela,i|
      @assign[i] = User.find_by(id: rela.assign_id)
    end
	end

	def update_issue
		@project = Project.find(params[:iid])
		@issue = Issue.find(params[:id])
		if @issue.update_attributes(params_issue)
			Log.create(issue_id: @issue.id,update_by: current_user.id,log_status: @issue.status,log_priority: @issue.priority)
			flash.now[:success] = "Your issue is successfull updated"
			redirect_to "/projects/#{@project.id}/show_issue_create/#{@issue.id}"
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
			params.require(:issue).permit(:issue_name,:issue_decription,:assign_id,:project_id,:user_id,:status,:priority,:start_date,:due_date)
		end
end
