class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @questions = Question.all
    @user.questions.build
    @question_options = Question.all.map{|q| [ q.body, q.id ] }
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      flash[:success] = 'User created'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'User not created'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @questions = Question.all
    @user.questions.build
  end

  def update
    @user = User.find(params[:id])
    if @user.update(whitelisted_params)
      flash[:success] = 'User updated'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'User not updated'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = 'User destroyed'
      redirect_to users_path
    else
      flash.now[:error] = 'User not destroyed'
      render 'show'
    end
  end

  private

  def whitelisted_params
    params.require(:user).permit(
                        :first_name, 
                        :last_name, 
                        :email, 
                        :age, 
                        :gender,
                        :responses_attributes => [
                          :value, 
                          :id, 
                          :question_id, 
                          :_destroy
                          ])
  end
end
