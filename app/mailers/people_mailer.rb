class PeopleMailer < ApplicationMailer
  default from: "hello@peopleapp.com"

  def send_email(person, new_person_fullname, subject, action)
    @person = person
    @new_person_fullname = new_person_fullname
    @action = action
    mail(to: @person.email, subject: subject)
  end

end
