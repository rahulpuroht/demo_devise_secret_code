class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validations
  validates :email, uniqueness: true
  validate :check_code, on: :create

  # Associations
  has_one :secret_code, dependent: :destroy
  has_one :role, dependent: :destroy

  attr_accessor :code


  after_create_commit :save_code, :assign_role

  def check_code
  	sc = SecretCode.find_by(code: self.code, user_id: nil)
    unless sc.present?
		errors.add(:code, "is not valid")
    end
  end

  def save_code
  	SecretCode.find_by(code: self.code).update(user_id: self.id) unless (self.role.role_type == "admin")
  end

  def assign_role
    self.create_role(role_type: "normal") unless (self.role.role_type == "admin")
  end

  def admin?
    (self.role.role_type == "admin")
  end

end
