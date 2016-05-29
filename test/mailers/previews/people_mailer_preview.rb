# Preview all emails at http://localhost:3000/rails/mailers/people_mailer
class PeopleMailerPreview < ActionMailer::Preview

  def new_person_preview
    PeopleMailer.new_person(Person.first, "Homer Jay Simpson")
  end

  def deleted_person_preview
    PeopleMailer.deleted_person(Person.first, "Homer Jay Simpson")
  end

end
