feature 'Shipping Matrix' do
  before(:each) do
    given_i_am_logged_into_the_cms
  end

  scenario 'creating shipping matrix' do
    when_i_create_a_new_shipping_matrix
    then_there_should_be_1_shipping_matrix
  end

  scenario 'editing shipping matrix' do
    given_i_have_1_shipping_matrix
    when_i_edit_a_shipping_matrix
    then_i_should_see_changes_to_the_shipping_matrix
  end
end

def given_i_am_logged_into_the_cms
  user = FactoryGirl.create(:admin_user)
  visit spree.admin_path
  fill_in :spree_user_email, with: user.email
  fill_in :spree_user_password, with: user.password
  click_button 'Login'
end

def given_i_have_1_shipping_matrix
 @matrix = FactoryGirl.create(:shipping_matrix)
end

def when_i_create_a_new_shipping_matrix
  visit spree.new_admin_shipping_matrix_path
  fill_in :shipping_matrix_name, with: 'UK next day'
  click_button 'Create'
end

def when_i_edit_a_shipping_matrix
  visit spree.edit_admin_shipping_matrix_path(@matrix)
  fill_in :shipping_matrix_name, with: 'UK next day updated'
  click_button 'Update'
end

def then_there_should_be_1_shipping_matrix
  expect(Spree::ShippingMatrix.count).to be(1)
  expect(page).to have_content('UK next day')
end

def then_i_should_see_changes_to_the_shipping_matrix
  expect(Spree::ShippingMatrix.count).to be(1)
  expect(page).to have_content('UK next day updated')
end
