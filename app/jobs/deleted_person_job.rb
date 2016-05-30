class DeletedPersonJob < ActiveJob::Base
  queue_as :emails_deleted

# Add a job to the queue :emails_deleted.
#
# id  - Id of person deleted
# name - Name of person deleted
#
# Send an email to all people in the database except the deleted one.

  def perform(id, name)
    Person.where.not(id: id).find_each do |p|
      PeopleMailer.deleted_person(p, name).deliver_now
      puts "Sending email to #{p.email}"
    end
  end
end
