FactoryGirl.define do
  factory :user do
    name                    "Paul Wagstaff"
    email                   "wagdog@gmail.com"
    password                "foobar"
    password_confirmation   "foobar"
  end
end