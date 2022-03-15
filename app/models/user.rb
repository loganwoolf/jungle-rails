class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, format: { with: /\A[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\z/, message: "must be a valid email address" }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
