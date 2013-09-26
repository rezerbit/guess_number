module SecretnumbersHelper

	def game_logic_for(user)

		user_number = params[:user_number]

	  if user_number.match /[0-9]{1,3}/		# user number validation, only number
	  	# Increment the try
      user.secretnumber.try = user.secretnumber.try.next
      secret_number = user.secretnumber.value
      user.secretnumber.save

      user_number = user_number.to_i
      
		  unless  secret_number == user_number
		    if secret_number < user_number
		      flash[:notice] = "#{@user.name}, zagadannoe chislo menshe #{params[:user_number]}"
		    else
		      flash[:notice] = "#{@user.name}, zagadannoe chislo bolshe #{params[:user_number]}"
		    end
	    else
	    	# Increment the win
	      user.secretnumber.win = user.secretnumber.win.next

	      generate_secret_value_for @user
	      
	      flash[:success] = "#{user.name}, vi otgadali chislo #{params[:user_number]}! 
	                              Zagadano novoe chislo."
	    end
		else			
	    flash[:error] = "#{@user.name}, vvedite chislo!"
		end
	end

	def generate_secret_value_for user
		user.secretnumber.value = rand(0..100)
		user.secretnumber.save
	end 
end
