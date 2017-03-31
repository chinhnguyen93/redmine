class UsersController < ApplicationController
  before_action :login, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params_user)
  	if @user.save
  		UserMailer.account_activation(@user).deliver_now
      flash.now[:info] = "Please check your email to activate your account."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params_user)
      flash.now[:success] = "Your profile is successfull updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def login
    if !logged_in
      flash.now[:danger] = "You are not log in. Please log in di!"
      redirect_to signin_path
    end
  end

  def correct_user
    return true if current_user == User.find(params[:id])
    flash.now[:danger] = "You cant edit another user"
    redirect_to root_url
  end

  private
  	def params_user
  		params.require(:user).permit(:email, :account, :password, :password_confirmation)
  	end

    
end
