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

  def is_a_valid_date
    errors.add(:birthdate, "is not a valid date.") if birthdate.present? and birthdate > Date.current
  end

  mount_uploader :picture, AvatarUploader

  after_create :send_emails_new_person
  before_destroy :send_emails_deleted_person

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    age = Date.today.year - birthdate.year
    Date.today < birthdate + age.years ? age-1: age
  end

  def send_emails_new_person
    NewPersonJob.perform_later(id, full_name)
  end

  def send_emails_deleted_person
    DeletedPersonJob.perform_later(id, full_name)
  end

end
