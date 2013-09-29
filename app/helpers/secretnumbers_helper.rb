# encoding: utf-8

module SecretnumbersHelper
	class Logic

		  def initialize(user, user_number)
		     @user = user
		     @user_number = user_number

		  end

    def get_message

      if user_number_valid?
        increment @user.secretnumber.try

        @secret_number = @user.secretnumber.value
        @user_number = @user_number.to_i

        unless  @secret_number == @user_number

          if @secret_number < @user_number
            return "#{@user.name}, загаданное число меньше #{@user_number}"
          else
            return "#{@user.name}, загаданное число больше #{@user_number}"
          end

        else
          increment @user.secretnumber.win

          generate_secret_value

          return "#{@user.name}, Вы отгадали число #{@user_number}!
                                  Загадано новое число."
        end

      else
        return "#{@user.name}, введите число!"
      end
    end


    protected

    def user_number_valid?
      # user number validation, only number
      return @user_number.match /[0-9]{1,3}/
    end

    def increment(x)
      x = x.next
      save
    end

    def generate_secret_value
      @user.secretnumber.value = rand(0..100)
      save
    end

    def save
      @user.secretnumber.save
    end
  end
end