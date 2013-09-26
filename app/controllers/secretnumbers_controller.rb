class SecretnumbersController < ApplicationController

  def index
    @user = current_user
    @secret_number = @user.secretnumber
  end

  def logic
    @user = current_user    
    game_logic_for @user

    redirect_to game_path
  end
end
