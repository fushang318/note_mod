FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "user#{n}"
    end
    sequence :email do |n|
      "#{name}#{n}@example.com"
    end
    password "1234"
  end

  factory :note ,class: NoteMod::Note do
    title 'title a'
    content 'content a'
  end
end
