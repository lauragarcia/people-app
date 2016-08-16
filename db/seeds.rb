# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Rake::Task['db:reset'].invoke

40.times do |i|
  person = Person.new(
    :first_name  => Faker::Name.first_name, 
    :last_name  => Faker::Name.last_name ,
    :birthdate  => Faker::Date.backward(30000), 
    :gender  => rand(2), 
    :email  => Faker::Internet.email, 
    :job  => Faker::Company.profession,  
    :bio  => Faker::Hipster.paragraph(2, true)
    )
  person.remote_picture_url = Faker::Avatar.image
  person.save
end