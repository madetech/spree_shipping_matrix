feature 'Shipping Matrix in checkout flow' do
  before(:each) do
    given_there_are_many_spree_roles
    and_there_are_payment_methods_and_zones
    and_there_is_1_shipping_matrix_with_rules [['entry', 26, '6.99'],
                                               ['entry', 52, '5.99'],
                                               ['vip', 26, '4.99'],
                                               ['vip', 52, '3.00'],
                                               ['ultra_vip', 26, '2.00'],
                                               ['ultra_vip', 52, '1.00'],
                                               ['press', 26, '0.00'],
                                               ['press', 52, '0.00']]
    and_there_is_1_shipping_method_with_matrix_calculator
  end

  [['entry', 26, '6.99'],
   ['entry', 52, '5.99'],
   ['vip', 26, '4.99'],
   ['vip', 52, '3.00'],
   ['ultra_vip', 26, '2.00'],
   ['ultra_vip', 52, '1.00'],
   ['press', 26, '0.00'],
   ['press', 52, '0.00']].each do |role, order_value, price|
    scenario "Delivery price as #{role}" do
      given_i_am_logged_in_as_user_with(role)
      when_my_basket_value_is(order_value)
      and_i_have_reached_the_delivery_stage_of_checkout
      then_i_should_see_the_delivery_price_of(price)
    end

    scenario "Cheapest shipping method for #{role}" do
      given_i_am_logged_in_as_user_with(role)
      when_my_basket_value_is(order_value)
      and_there_is_more_than_one_shipping_method
      then_i_should_see_the_cheapest_delivery_price_of(price)
    end
  end

  scenario 'Free shipping method always wins' do
    given_i_am_logged_in
    when_there_is_a_free_delivery_method
    then_the_delivery_should_be_free
  end
end

def given_there_are_many_spree_roles
  [:entry, :vip, :ultra_vip, :press].each do |role|
    create(:role, name: role)
  end
end

def and_there_are_payment_methods_and_zones
  FactoryGirl.create(:check_payment_method)
  country = FactoryGirl.create(:country)
  Spree::Zone.global.members << Spree::ZoneMember.create(zoneable: country)
  country.states << FactoryGirl.create(:state, country: country)
end

def and_there_is_1_shipping_matrix_with_rules(rules)
  @matrix = create(:shipping_matrix)

  rules.each do |role, min_line_item_total, amount|
    @matrix.rules.create(role: Spree::Role.find_by(name: role),
                         min_line_item_total: min_line_item_total,
                         amount: amount)
  end
end

def and_there_is_1_shipping_method_with_matrix_calculator
  calc = Spree::ShippingMatrixCalculator.new(preferred_matrix_id: @matrix.id)
  create(:shipping_method, calculator: calc)
end

def when_my_basket_value_is(value)
  @order = Spree::Order.create!(user: @user)
  line_item = create(:line_item, price: value, order: @order)
  line_item.variant.update!(price: value)
  @order.reload
end

def and_i_have_reached_the_delivery_stage_of_checkout
  @order.bill_address = FactoryGirl.create(:address, :country_id => Spree::Zone.global.members.first.zoneable.id)
  @order.ship_address = FactoryGirl.create(:address, :country_id => Spree::Zone.global.members.first.zoneable.id)
  @order.next!
  @order.next!
  Spree::CheckoutController.any_instance.stub(:current_order => @order)
end

def and_there_is_more_than_one_shipping_method
  create(:shipping_method)
  and_i_have_reached_the_delivery_stage_of_checkout
end

def when_there_is_a_free_delivery_method
  create(:free_shipping_method)
  when_my_basket_value_is(10)
  and_i_have_reached_the_delivery_stage_of_checkout
end

def then_i_should_see_the_delivery_price_of(expected_delivery)
  visit spree.checkout_state_path(:delivery)
  expect(page).to have_content(expected_delivery)
end

def then_i_should_see_the_cheapest_delivery_price_of(expected_delivery)
  then_i_should_see_the_delivery_price_of(expected_delivery)
end

def then_the_delivery_should_be_free
  then_i_should_see_the_delivery_price_of('0.00')
end
