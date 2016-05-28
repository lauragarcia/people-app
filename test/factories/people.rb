require 'faker'

FactoryGirl.define do
  factory :person do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.birthdate { Faker::Date.backward(30000) }
    f.gender { rand(2) }
    f.email { Faker::Internet.email }
    f.job { Faker::Company.profession } 
    f.bio { Faker::Hipster.paragraph(2, true) }
  end
end
