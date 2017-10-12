class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true

  has_one :secret_code

  attr_accessor :code

  validate :check_code, on: :create

  after_create_commit :save_code

  def check_code
  	sc = SecretCode.find_by(code: self.code, user_id: nil)
    unless sc.present?
		errors.add(:code, "is not valid")
    end
  end

  def save_code
  	SecretCode.find_by(code: self.code).update(user_id: self.id) unless (self.email == "admin@example.com")
  end

  def admin?
    (self.email == "admin@example.com")
  end

end
