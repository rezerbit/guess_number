# encoding: utf-8

require 'spec_helper'

describe "User pages" do

  subject { page }

#-------------------------------------------------------------------------------
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: 'Профиль игрока') }
    it { should have_selector('title', text: full_title(user.name)) }

  end

#-------------------------------------------------------------------------------
  describe "signup page" do

    before { visit signup_path }

    it { should have_selector('h1',    text: 'Регистрация') }
    it { should have_selector('title', text: full_title('Регистрация')) }

    let(:submit) { "Создать игрока" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Регистрация') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_valid_signup_info }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('rezerbit@gmail.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Добро пожаловать') }

        it { should have_link('Игра', href: game_path) }
        it { should have_link('Рейтинг', href: rating_path) }
        it { should have_link('Профиль', href: user_path(user)) }
        it { should have_link('Изменить профиль', href: edit_user_path(user)) }
        it { should have_link('Выйти', href: signout_path) }
        it { should_not have_link('Войти', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Выйти" }
          it { should have_link('Войти') }
        end
      end
    end
  end

#-------------------------------------------------------------------------------
  describe "edit profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    it { should have_selector('h1',    text: "Изменение профиля") }
    it { should have_selector('title', text: "Изменение профиля") }
    it { should have_link('Изменить', href: 'http://gravatar.com/emails') }

    describe "with invalid information" do
      before { click_button "Сохранить изменения" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Имя",                  with: new_name
        fill_in "Email",                with: new_email
        fill_in "Пароль",               with: user.password
        fill_in "Подтверждение пароля", with: user.password
        click_button "Сохранить изменения"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_success_message('Профиль изменен!') }
      it { should have_link('Выйти', href: signout_path) }

      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

#-------------------------------------------------------------------------------
  describe "rating page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit rating_path
    end

    it { should have_selector('title', text: 'Рейтинг') }
    it { should have_selector('h1',    text: 'Рейтинг') }

    #it "should list each user" do
      #User.all.each do |user|
        #page.should have_selector('li', text: user.name)
      #end
    #end
  end
end