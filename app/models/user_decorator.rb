User.class_eval do
  belongs_to :user_group
  attr_accessible :user_group_id
  
  def create_adjustment_for(order)
     return false
  end
end
