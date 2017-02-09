require 'bcrypt'

class User < ActiveRecord::Base

  has_many :likes, :through => :posts, dependent: :destroy

  has_many :articles, dependent: :destroy

attr_accessor :remember_token

validates :name, presence: true
VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true,
           format: { with: VALID_EMAIL},
           uniqueness: { case_sensitive: false}

#has_secure_password
#  validates :password, presence: true


 def User.digest(string)

    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
   BCrypt::Password.create(string)
 end

 def User.new_token
    SecureRandom.urlsafe_base64
 end
 
 def remember
    self.remember_token = User.new_token

    update_attribute(:remember_digest, User.digest(remember_token))
    #puts cookies
    #cookies.permanent[:remember_token] = user.remember_token
 end

def authenticated?(remember_token)
	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
end

def forget
    update_attribute(:remember_digest, nil)
end

end
