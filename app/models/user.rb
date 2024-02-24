class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable, :trackable
  
  enum role: { user: 'user', admin: 'admin' }

  # ============= relations ============
  
  
  
  # ============= validations ============
  
  validates :role, presence: true, inclusion: { in: roles.keys }
  
  
  # ============= scopes ============
  
  
  
  # ============= methods ===========
  
  
  
end
