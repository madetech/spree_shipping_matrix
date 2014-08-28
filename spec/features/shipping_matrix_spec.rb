feature 'Shipping Matrix' do
  before(:each) do
    given_i_am_logged_into_the_cms
  end

  scenario 'creating shipping matrix' do
    when_i_create_a_new_shipping_matrix
    then_the_num_of_matrices_should_be(1)
    and_the_num_of_rules_should_be(1)
  end

  scenario 'editing shipping matrix' do
    given_i_have_a_shipping_matrix_with(num_of_rules: 1)
    when_i_edit_a_shipping_matrix
    then_i_should_see_changes_to_the_shipping_matrix
  end

  scenario 'adding rule to shipping matrix', js: true do
    given_i_have_a_shipping_matrix_with(num_of_rules: 1)
    when_i_add_2_rules_to_the_shipping_matrix
    then_the_num_of_rules_should_be(3)
  end

  scenario 'removing rule from shipping matrix', js: true do
    given_i_have_a_shipping_matrix_with(num_of_rules: 2)
    when_i_remove_1_rule
    then_the_num_of_rules_should_be(1)
  end
end

def given_i_have_a_shipping_matrix_with(with)
 @matrix = create(:shipping_matrix_with_rules, with)
end

def when_i_create_a_new_shipping_matrix
  visit spree.new_admin_shipping_matrix_path
  fill_in :shipping_matrix_name, with: 'UK next day'
  fill_in :shipping_matrix_rules_attributes_0_min_line_item_total, with: '40'
  fill_in :shipping_matrix_rules_attributes_0_amount, with: '2'
  click_button 'Create'
end

def when_i_edit_a_shipping_matrix
  visit spree.edit_admin_shipping_matrix_path(@matrix)
  fill_in :shipping_matrix_name, with: 'UK next day updated'
  fill_in :shipping_matrix_rules_attributes_0_amount, with: '4'
  click_button 'Update'
end

def when_i_add_2_rules_to_the_shipping_matrix
  visit spree.edit_admin_shipping_matrix_path(@matrix)

  fill_in :shipping_matrix_rules_attributes_1_min_line_item_total, with: '40'
  fill_in :shipping_matrix_rules_attributes_1_amount, with: '4'

  click_link 'Add rule'
  fill_in :shipping_matrix_rules_attributes_2_min_line_item_total, with: '20'
  fill_in :shipping_matrix_rules_attributes_2_amount, with: '8'

  click_button 'Update'
end

def when_i_remove_1_rule
  visit spree.edit_admin_shipping_matrix_path(@matrix)
  click_link 'Remove'
  click_button 'Update'
end

def then_the_num_of_matrices_should_be(expected_num)
  expect(Spree::ShippingMatrix.count).to be(expected_num)
  expect(page).to have_content('UK next day')
end

def then_the_num_of_rules_should_be(expected_num)
  expect(Spree::ShippingMatrixRule.count).to be(expected_num)
end

def and_the_num_of_rules_should_be(expected_num)
  then_the_num_of_rules_should_be(expected_num)
end

def then_i_should_see_changes_to_the_shipping_matrix
  then_the_num_of_matrices_should_be(1)
  and_the_num_of_rules_should_be(1)
  expect(page).to have_content('UK next day updated')
end
