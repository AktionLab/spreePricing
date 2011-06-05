Variant.class_eval do

  def price
        return read_attribute(:price) if User.current.nil? or User.current.user_group.nil?
        return UserGroupsVariant.where(:user_group_id => User.current.user_group.id, :variant_id => self.id).try(:first).try(:price) || read_attribute(:price) if User.current.user_group.calculator.class == Calculator::PerVariantPricing
	variant = self
	part = User.current.user_group.calculator.preferred_flat_percent.abs / 100.0
    if User.current.user_group.calculator.preferred_based_on_cost_price
      if !variant.cost_price.nil? && variant.cost_price > 0
        variant.cost_price * (1 + part)
      else
        variant.read_attribute(:price)
      end
    else
      variant.read_attribute(:price) * (1 - part)
    end


  end

  def price_for_user(user)
    if user && user.user_group
      user.user_group.calculator.compute_item(self)
    else
      price
    end
  end
end
