class UsersAffiliation < ApplicationRecord
  
  # ============= callbacks ============
  
  after_create :increment_counters
  after_destroy :decrement_counters
  
  # ============= relations ==============
  
  belongs_to :user
  belongs_to :affiliation
  
  # ============= methods ==============
  
  def increment_counters
    users = affiliation.users_count 
    affiliation.update(users_count: users + 1)
  end

  def decrement_counters
    users = affiliation.users_count 
    affiliation.update(users_count: users - 1)
  end
  
end