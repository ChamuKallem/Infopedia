class User < ActiveRecord::Base
  # has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :wikis, through: :collaborators
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  enum role: [:admin, :standard, :premium]
  after_initialize :set_default_role, :if => :new_record?
  delegate :wikis, to: :collaborators

  def set_default_role
    self.role ||= :standard
  end
  def collaborators
    Collaborator.where(user_id: id)
  end

  # def admin?
  #   role == 0
  # end
  # def standard?
  #   role == 1
  # end
  # def premium?
  #   role == 2
  # end
end
