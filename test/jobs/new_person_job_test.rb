require 'test_helper'

class NewPersonJobTest < ActiveJob::TestCase
  
  def setup
    10.times{FactoryGirl.create(:person)}
  end

  test 'create person should add job to queue' do

    assert_enqueued_jobs(1) do
      FactoryGirl.create(:person)
    end

  end

  test 'should send many emails' do

    new_person = FactoryGirl.build(:person)

    assert_difference 'ActionMailer::Base.deliveries.size', + 10  do
      NewPersonJob.perform_now(new_person.id, new_person.full_name )
    end 
  end
end
