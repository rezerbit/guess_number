class SecretnumbersController < ApplicationController

  def game
    @user = current_user
    #@secret_number = @user.secretnumber
  end

  def logic
    @user = current_user

    @logic = Logic.new(@user, params[:user_number])
    flash[:notice] = @logic.get_message

    redirect_to game_path
  end
end
