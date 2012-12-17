FactoryGirl.define do
  factory :user do
    name      "Jesse"
    email     "jesse@example.org"
    password  "foobar"
    password_confirmation "foobar"
  end
end
