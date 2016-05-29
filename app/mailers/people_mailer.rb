class PeopleMailer < ApplicationMailer
  default from: "hello@peopleapp.com"

  def new_person(person, new_person_fullname)
    @person = person
    @new_person_fullname = new_person_fullname
    mail(to: @person.email, subject: 'People App - New person added')
  end

  def deleted_person(person, new_person_fullname)
    @person = person
    @new_person_fullname = new_person_fullname
    mail(to: @person.email, subject: 'People App - A deleted person')
  end

end
