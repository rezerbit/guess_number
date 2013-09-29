FactoryGirl.define do
  factory :user do
    name     "Fyodor Parmanchukov"
    email    "rezerbit@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :secretnumber do
    value 22
    try   33
    win   44
    user
  end
end