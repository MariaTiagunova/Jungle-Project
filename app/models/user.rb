class User < ApplicationRecord

  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password)
    # Find the user by email (case-insensitive)
    user = User.where('lower(email) = ?', email.downcase.strip).first

    # If the user exists and the password is correct, return the user; otherwise, return nil
    user&.authenticate(password)


  end

end
