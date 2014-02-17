gem 'faker'

FactoryGirl.define do 
  factory :item do 
    description "This is a test" 
    duedate "2014-02-20"
  end
end
