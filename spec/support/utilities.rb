# encoding: utf-8

include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Пароль", with: user.password
  click_button "Войти"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Пароль", with: user.password
  click_button "Войти"
end

def fill_valid_signup_info
  fill_in "Имя",                  with: "Fyodor Parmanchukov"
  fill_in "Email",                with: "rezerbit@gmail.com"
  fill_in "Пароль",               with: "foobar"
  fill_in "Подтверждение пароля", with: "foobar"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_notice_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-notice', text: message)
  end
end

