class NewPersonJob < ActiveJob::Base
  queue_as :emails_new

# Add a job to the queue :emails_new.
#
# id  - Id of person created
# name - Name of person created
#
# Send an email to all people in the database except the created one.
  def perform(id, name)
    Person.where.not(id: id).find_each do |p|
      PeopleMailer.new_person(p, name).deliver_now
      puts "Sending email to #{p.email}"
    end
  end
end
