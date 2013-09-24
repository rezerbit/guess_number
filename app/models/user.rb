class User < ActiveRecord::Base
  attr_accessible :name, :email, :guessed, :win
end
