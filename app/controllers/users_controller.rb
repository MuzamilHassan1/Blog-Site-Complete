class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles=@user.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @users=User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      #making login session for the users(once they signed up)
      session[:user_id] = @user.id
      flash[:notice]="Welcom to the Alpha Blog #{@user.username}, You have successfully signed up"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice]="You've successfully updated your information"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    #if currnt_user == admin and delete user != admin ==> no nill
    session[:user_id]=nil if @user==current_user
    flash[:notice]="Account and all associated articles deleted successfully"
    redirect_to articles_path
  end

  private
  def user_params
    params.require(:user).permit(:username,:email, :password)
  end

  def find_user
    @user=User.find(params[:id])
  end

  def require_same_user
    if current_user !=@user && !current_user.admin?
      flash[:alert] = "you can only edit or delete your own profile"
      redirect_to @user
    end
  end
end
