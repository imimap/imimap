

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "foofoofoo123123"
    password_confirmation "foofoofoo123123"
    publicmail true
    mailnotif true
    after(:build) do |user|
      user.student ||= FactoryGirl.build(:student, user: user)
    end
  end
end

