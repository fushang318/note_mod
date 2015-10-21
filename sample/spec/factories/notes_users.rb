FactoryGirl.define do
  factory :user ,class: User do
    name "tom"
    email { "#{name}@example.com" }
    password "1234"
  end
  
  factory :note ,class: NoteMod::Note do
    title 'title a'
    content 'content a'
  end
end