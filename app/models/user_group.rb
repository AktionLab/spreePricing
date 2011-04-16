class UserGroup < ActiveRecord::Base
  has_many :users, :dependent => :nullify
  validates :name, :presence => true
  has_many :user_groups_variants
  has_many :variants, :through => :user_groups_variants
  
  calculated_adjustments
  
  def calculator_description
    return t(:none) if calculator.nil?
    if calculator.preferred_based_on_cost_price
      "#{I18n.t(:cost_price)} + #{calculator.preferred_flat_percent}%"
    else
      "#{I18n.t(:price)} - #{calculator.preferred_flat_percent}%"
    end
  end
end
