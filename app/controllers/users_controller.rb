class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      init_secret_number

      sign_in @user

      flash[:success] = "Dobro pojalovat, #{@user.name}!"
      redirect_to game_path
    else
      render 'new'
    end
  end

  def show_all_users
    @all_users = User.all
    #todo: sort by win 
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil izmenen"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    
  end
end
