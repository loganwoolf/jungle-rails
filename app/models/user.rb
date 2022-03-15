class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, format: { with: /\A[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\z/, message: "must be a valid email address" }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  before_save :downcase_email
  before_save :capitalize_names

  def downcase_email
    self.email.downcase!
  end

  def capitalize_names
    self.first_name.capitalize!
    self.last_name.capitalize!
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
