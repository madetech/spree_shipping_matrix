feature 'Shipping Matrix in checkout flow' do
  before(:each) do
    given_there_are_many_spree_roles
    and_there_are_payment_methods_and_zones
    and_there_is_1_shipping_matrix_with_num_of_rules(1)
    and_there_is_1_shipping_method_with_matrix_calculator
  end

  [[:entry, 26, 2.99],
   [:entry, 52, 0.0],
   [:vip, 26, 2.99],
   [:vip, 52, 0.0],
   [:ultra_vip, 26, 0.0],
   [:ultra_vip, 52, 0.0],
   [:press, 26, 0.0],
   [:press, 52, 0.0]].each do |role, order_value, price|
    scenario "Delivery price as #{role}" do
      given_i_am_logged_in_as_user_with(role)
      when_i_have_reached_the_delivery_stage_of_checkout
      and_my_basket_value_is(order_value)
      then_i_should_see_the_delivery_price_of(price)
    end

    scenario "Cheapest shipping method for #{role}" do
      given_i_am_logged_in_as_user_with(role)
      when_there_is_more_than_one_shipping_method
      and_my_basket_value_is(order_value)
      then_i_should_see_the_cheapest_delivery_price_of(price)
    end
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
  Spree::Zone.global.members << Spree::ZoneMember.create(:zoneable => country)
  country.states << FactoryGirl.create(:state, :country => country)
end

def and_there_is_1_shipping_matrix_with_num_of_rules(num_of_rules)
 @matrix = create(:shipping_matrix_with_rules, num_of_rules: num_of_rules)
end

def and_there_is_1_shipping_method_with_matrix_calculator
  calc = Spree::ShippingMatrixCalculator.new(preferred_matrix_id: @matrix.id)
  create(:shipping_method, calculator: calc)
end

def when_i_have_reached_the_delivery_stage_of_checkout
  order = OrderWalkthrough.up_to('delivery')
  order.update(user_id: @user.id)
  Spree::CheckoutController.any_instance.stub(:current_order => order)
end

def and_my_basket_value_is(value)
  Spree::LineItem.first.update(price: value)
end

def when_there_is_more_than_one_shipping_method
  create(:shipping_method)
  when_i_have_reached_the_delivery_stage_of_checkout
end

def then_i_should_see_the_delivery_price_of(expected_delivery)
  visit spree.checkout_state_path(:delivery)
  expect(page).to have_content(expected_delivery)
end

def then_i_should_see_the_cheapest_delivery_price_of(expected_delivery)
  then_i_should_see_the_delivery_price_of(expected_delivery)
end
