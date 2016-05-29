class NewPersonJob < ActiveJob::Base
  queue_as :emails_new

  def perform(id, name)
    Person.where.not(id: id).find_each do |p|
      PeopleMailer.new_person(p, name).deliver_now
      puts "Sending email to #{p.email}"
    end
  end
end
