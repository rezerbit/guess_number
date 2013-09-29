# encoding: utf-8

require 'spec_helper'

describe "Secretnumber pages" do

  subject { page }

  describe "game page" do

    describe "for non-signed-in users" do
      before { visit game_path }

      it { should_not have_selector('title', text: 'Игра') }
      it { should_not have_selector('h1', text: 'Игра') }
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit game_path
      end

      it { should have_selector('title', text: user.name) }
      it { should have_selector('h1', text: 'Игра') }

      describe "click with invalid user number" do

        describe "empty number" do
          before { click_link "Проверить!" }

          it { should have_error_message('введите число') }
        end

        describe "Abracadabra" do
          let(:number)  { "Abracadabra" }
          before do
            fill_in "Я думаю, что это число:", with: number
            click_link "Проверить!"
          end

          it { should have_error_message('введите число') }
        end
      end

      describe "click with valid user number" do
        before do
          @secretnumber = user.build_secretnumber(value: 11, try: 33, win: 44)
          fill_in "Я думаю, что это число:",   with: number
          click_link "Проверить!"
        end

        describe "if user number >" do
          let(:number)  { '25' }

          it { should have_notice_message('меньше') }
          it { should_not have_error_message('введите число') }
        end

        describe "if user number <" do
          let(:number)  { '5' }

          it { should have_notice_message('больше') }
          it { should_not have_error_message('введите число') }
        end

         describe "if user number =" do
          let(:number)  { '11' }

          it { should have_success_message('отгадали') }
          it { should_not have_error_message('введите число') }
        end
      end
    end

  end

end