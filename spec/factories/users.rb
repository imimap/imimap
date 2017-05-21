FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foofoo"
    password_confirmation "foofoo"
    publicmail true
    mailnotif true
    after(:build) do |user|
      user.student ||= FactoryGirl.build(:student, user: user)
    end
  end
end
