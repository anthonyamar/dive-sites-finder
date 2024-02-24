class UsersActivity < ApplicationRecord
  
  # ============= callbacks ============
  
  after_create :increment_counters
  after_destroy :decrement_counters
  
  # ============= relations ==============
  
  belongs_to :user
  belongs_to :activity
  
  # ============= methods ==============
  
  def increment_counters
    users = activity.users_count 
    activity.update(users_count: users + 1)
  end

  def decrement_counters
    users = activity.users_count 
    activity.update(users_count: users - 1)
  end
  
end