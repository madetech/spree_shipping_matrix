def given_i_am_logged_into_the_cms
  user = FactoryGirl.create(:admin_user)
  visit spree.admin_path
  fill_in :spree_user_email, with: user.email
  fill_in :spree_user_password, with: user.password
  click_button 'Login'
end
