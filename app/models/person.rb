class Person < ActiveRecord::Base

  validates :first_name, :last_name, :email, :birthdate , presence: true

  validates :first_name, length: { maximum: 75 }
  validates :last_name, length: { maximum: 75 }
  
  validates :email, length: { maximum: 254 }
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: "%{value} is not a valid email."}
  
  validates :job, length: { maximum: 75 }
  validate :is_a_valid_date

  enum gender: [ 'female', 'male']

# Validate that the birthdate shouldn't be da future date.
#
# self  - Objet type Person
#
# Examples
#
#   object.is_a_valid_date
#   # => true
#
# Returns true or add and error message and rollback the transaction.

  def is_a_valid_date
    errors.add(:birthdate, "is not a valid date.") if birthdate.present? and birthdate > Date.current
  end

  mount_uploader :picture, AvatarUploader

  after_create :send_emails_new_person
  before_destroy :send_emails_deleted_person


# Return first_name + last_name
#
# self  - Objet type Person
#
# Examples
#
#   object.full_name
#   # => Homer Jay Simpsons
#
# Returns a string
  def full_name
    "#{first_name} #{last_name}"
  end

# Calculates the age of and objet person.
#
# self  - Objet type Person
#
# Examples
#
#   object.age
#   # => 45
#
# Returns an interger
  def age
    age = Date.today.year - birthdate.year
    Date.today < (birthdate + age.years) ? age-1 : age
  end

# Send emails to all the people notifying that a person has been created.
#
# self  - Objet type Person
#
# Raised after create a person
# Adds a job to a resque queue
  def send_emails_new_person
    NewPersonJob.perform_later(id, full_name)
  end

# Send emails to all the people notifying that a person has been deleted.
#
# self  - Objet type Person
#
# Raised after create a person
# Adds a job to a resque queue
  def send_emails_deleted_person
    DeletedPersonJob.perform_later(id, full_name)
  end

end
