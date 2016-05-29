class DeletedPersonJob < ActiveJob::Base
  queue_as :emails_deleted

  def perform(id, name)
    Person.where.not(id: id).find_each do |p|
      PeopleMailer.deleted_person(p, name).deliver_now
      puts "Sending email to #{p.email}"
    end
  end
end
