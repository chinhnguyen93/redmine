class User < ApplicationRecord
  has_many :projects
  has_many :issues
	attr_accessor :activation_token
	before_create :create_activation_digest
	before_save :downcase_account
	has_secure_password
	VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 30 }, format: { with: VALID_REGEX }
	validates :account, presence: true, length: { maximum: 10 }, uniqueness: { case_sensetive: false }
	validates :password, presence: true, allow_nil: true
	def User.new_token
    SecureRandom.urlsafe_base64
  end
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private
  	def downcase_account
			self.account = account.downcase
		end

  	def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

