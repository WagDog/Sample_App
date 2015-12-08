# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Check out Rubular to test REGEX expressions at http://rubular.com/


class User < ActiveRecord::Base
  #attr_accessible :name, :email, :password, :password_confirmation # Deprecated. This is now done in the controller
  has_secure_password

  before_save {|user| user.email = email.downcase}  # Position 7434
  # before_save{self.email.downcase!} # Another way of checking Position 7948
  before_save :create_remember_token

  validates(:name, presence: true, length:{maximum: 50})
  VALID_EMAIL_REGEX = /\A[\w +\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, format:{with: VALID_EMAIL_REGEX}, uniqueness:{case_sensitive: false}) #Position 7316 for validations
  validates(:password, presence: true, length:{minimum: 6})
  validates(:password_confirmation, presence: true)

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end