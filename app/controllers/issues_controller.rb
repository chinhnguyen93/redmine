class IssuesController < ApplicationController
	def edit
		@project = Project.find(params[:id])
		@issue = Issue.find(params[:iid])
	end

	def update
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
end
