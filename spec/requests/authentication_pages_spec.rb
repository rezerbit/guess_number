# encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Войти') }
    it { should have_selector('title', text: 'Войти') }

    describe "with invalid information" do
      before { click_button "Войти" }

      it { should have_selector('title', text: 'Войти') }
      it { should have_selector('div.alert.alert-error', text: 'Неверный') }

      describe "after visiting another page" do
        before { click_link "Угадай число!" }
        it { should_not have_error_message('Неверный ') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_selector('title', text: user.name) }
      it { should have_selector('h1', text: 'Игра') }

      it { should have_link('Игра', href: game_path) }
      it { should have_link('Рейтинг', href: rating_path) }
      it { should have_link('Профиль', href: user_path(user)) }
      it { should have_link('Изменить профиль', href: edit_user_path(user)) }
      it { should have_link('Выйти', href: signout_path) }
      it { should_not have_link('Войти', href: signin_path) }
    end
  end

#-------------------------------------------------------------------------------
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Войти') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "visiting the rating page" do
          before { visit rating_path }
          it { should have_selector('title', text: 'Войти') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Изменение профиля')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
