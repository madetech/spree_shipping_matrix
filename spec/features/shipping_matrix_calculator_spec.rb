feature 'Shipping Matrix Calculator' do
  before(:each) do
    given_i_am_logged_into_the_cms
    and_i_have_shipping_category
    and_i_have_shipping_matrices_and_rules
  end

  scenario 'creating a shipping method using matrix calculator', js: true do
    when_i_create_a_new_shipping_method_using_matrix_calculator
    then_the_num_of_shipping_methods_should_be(1)
  end
end

def and_i_have_shipping_category
  FactoryGirl.create(:shipping_category)
end

def and_i_have_shipping_matrices_and_rules
  FactoryGirl.create(:shipping_matrix_with_rules, num_of_rules: 3)
end

def when_i_create_a_new_shipping_method_using_matrix_calculator
  visit spree.new_admin_shipping_method_path
  fill_in :shipping_method_name, with: 'UK Next Day'
  fill_in :shipping_method_admin_name, with: 'UK Next Day'
  all('[type=checkbox]').each { |checkbox| checkbox.set(true) }
  select2 'Shipping Matrix Calculator', from: 'Calculator'
  click_button 'Create'
end

def then_the_num_of_shipping_methods_should_be(expected_num)
  expect(page).to have_content('has been successfully created!')
  expect(Spree::ShippingMethod.count).to be(expected_num)
end
