# encoding: utf-8

module SecretnumbersHelper
	class Logic

		  def initialize(user, user_number)
		     @user = user
		     @user_number = user_number

		  end

    def get_message

      if @user_number.match /[0-9]{1,3}/   # user number validation, only number
        # Increment the try
        @user.secretnumber.try = @user.secretnumber.try.next
        secret_number = @user.secretnumber.value
        @user.secretnumber.save

        @user_number = @user_number.to_i

        unless  secret_number == @user_number
          if secret_number < @user_number
            return "#{@ser.name}, загаданное число меньше #{@user_number}"
          else
            return "#{@user.name}, загаданное число больше #{@user_number}"
          end
        else
          # Increment the win
          @user.secretnumber.win = @user.secretnumber.win.next

          generate_secret_value_for @user

          return "#{user.name}, Вы отгадали число #{user_number}!
                                  Загадано новое число."
        end
      else
        return "#{@user.name}, введите число!"
      end
    end


    protected

    def generate_secret_value
      @user.secretnumber.value = rand(0..100)
      @user.secretnumber.save
    end
  end
end