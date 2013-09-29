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
  attr_accessible :value, :try, :win
  belongs_to :user

  validates :user_id,
    presence: true,
    numericality: {
      only_integer: true,
      allow_nil: false,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 1000000,
      message: "can only be whole number between 1 and 1000000." }

  validates :value,
    presence: true,
    numericality: {
      only_integer: true,
      allow_nil: false,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100,
      message: "can only be whole number between 0 and 100." }

  validates :try,
    presence: true,
    numericality: {
      only_integer: true,
      allow_nil: false,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1000000,
      message: "can only be whole number between 1 and 1000000." }

  validates :win,
    presence: true,
    numericality: {
      only_integer: true,
      allow_nil: false,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 1000000,
      message: "can only be whole number between 1 and 1000000." }
end
