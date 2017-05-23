FactoryGirl.define do
  factory :user do
    email 'tester@abc.pl'
    password '123412341234'
    password_confirmation '123412341234'
    confirmed_at Date.today
  end
end
