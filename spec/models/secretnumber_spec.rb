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

require 'spec_helper'

describe Secretnumber do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @secretnumber = user.build_secretnumber(value: 11, try: 33, win: 44)
  end

  subject { @secretnumber }

  it { should respond_to(:value) }
  it { should respond_to(:user_id) }
  it { should respond_to(:try) }
  it { should respond_to(:win) }

  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Secretnumber.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @secretnumber.user_id = nil }
    it { should_not be_valid }
  end
end
