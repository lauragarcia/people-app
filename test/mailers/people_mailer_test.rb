require 'test_helper'

class PeopleMailerTest < ActionMailer::TestCase

  def setup
    @person = FactoryGirl.create(:person)
  end

  test "new person email" do
    
    email = PeopleMailer.new_person(@person, "Homer Jay Simpsons").deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
 
    
    assert_equal ['hello@peopleapp.com'], email.from
    assert_equal [@person.email], email.to
    assert_equal 'People App - New person added', email.subject

  end

  test "deleted person email" do
    
    email = PeopleMailer.deleted_person(@person, @person.full_name).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
 
    
    assert_equal ['hello@peopleapp.com'], email.from
    assert_equal [@person.email], email.to
    assert_equal 'People App - A deleted person', email.subject

  end

end
