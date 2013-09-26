# == Schema Information
#
# Table name: secretnumbers
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  try        :integer
#  win        :integer
#

class Secretnumber < ActiveRecord::Base
  attr_accessible :value, :user_id, :try, :win
  belongs_to :user

  validates :user_id, presence: true
  validates :value, presence: true, 
                    numericality: { only_integer: true, less_than: 101 }

  validates :try, presence: true, numericality: { only_integer: true, less_than: 10000 }
  validates :win, presence: true,  numericality: { only_integer: true, less_than: 1000 }
end
