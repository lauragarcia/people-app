require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @person = FactoryGirl.create(:person)
  end

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_presence_of(:birthdate)

  should validate_length_of(:first_name).is_at_most(75)
  should validate_length_of(:last_name).is_at_most(75)
  should validate_length_of(:email).is_at_most(254)
  should validate_length_of(:job).is_at_most(75)

  should validate_uniqueness_of(:email)

  test "should not save person with future birthdates" do 
    @person.birthdate = Date.current + 1.year
    assert_not @person.valid?, "Birthdate can be future dates"
  end

  test "should not save person with wrong emails" do 
    @person.email = "asdfghjklñ"
    assert_not @person.valid?, "Email is not valid"
  end

  test "should be a valid person" do 
    assert @person.valid?, "Person is not valid"
  end

  test "should return full name string" do
    assert_equal @person.full_name, "#{@person.first_name} #{@person.last_name}" 
  end

end
