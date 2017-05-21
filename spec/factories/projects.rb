FactoryGirl.define do
  factory :project do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "Project #{n}" }
    user
  end
end
