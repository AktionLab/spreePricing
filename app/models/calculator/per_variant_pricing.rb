class Calculator::PerVariantPricing < Calculator

  def self.description
    I18n.t("per_variant_pricing")
  end

  def self.register
    super
    UserGroup.register_calculator(self)
  end

  def compute(object)
<<<<<<< HEAD

    return unless object.present? and object.line_items.present? and object.user.present? and object.user.user_group.present?

    item_total = object.line_items.map(&:amount).sum
    
    item_cost_price_total = object.line_items.map do |li| 
        puts UserGroupsVariant.where (:user_group_id => object.user.user_group.id, :variant_id => li.variant_id).first.price
        (li.variant.price * li.quantity) - UserGroupsVariant.where (:user_group_id => object.user.user_group.id, :variant_id => li.variant_id).first.price * li.quantity
    end.sum
    
    0 - item_cost_price_total
  end
  
  def compute_item(variant)
      variant.price_for_user(@current_user)
=======
    return unless object.present? and object.line_items.present? and object.user.present?

    part = self.preferred_flat_percent.abs / 100.0
    item_total = object.line_items.map(&:amount).sum
    
    item_cost_price_total = object.line_items.map do |li| 
        li.variant.price_for_user(object.user_group) * li.quantity
        
      end.sum
  end
  
  def compute_item(variant)
    part = self.preferred_flat_percent.abs / 100.0
    
    if self.preferred_based_on_cost_price
      if !variant.cost_price.nil? && variant.cost_price > 0
        variant.cost_price * (1 + part)
      else
        variant.price
      end
    else
      variant.price * (1 - part)
    end
>>>>>>> 15845eea5165d61cd5eb6856b3fac5cffb421a61
  end
end
