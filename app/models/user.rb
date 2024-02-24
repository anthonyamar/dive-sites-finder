class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable, :trackable
  
  enum role: { user: 'user', admin: 'admin' }

  # ============= relations ============
  
  has_many :users_activities, dependent: :destroy
  has_many :activities, through: :users_activities
  has_many :users_affiliations, dependent: :destroy
  has_many :affiliations, through: :users_affiliations
  
  # ============= validations ============
  
  validates :role, presence: true, inclusion: { in: roles.keys }
  
  
  # ============= scopes ============
  
  
  
  # ============= methods ===========
  
  
  
end
