require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'john', 'john@example.com', 'password'

    expect(page).to have_content('Logout John')
  end

  scenario 'with invalid email' do
    sign_up_with 'visitor', 'invalid_email', 'password'

    expect(page).to have_content('Sign up')
  end

  scenario 'with blank password' do
    sign_up_with 'jane', 'jane@example.com', ''

    expect(page).to have_content('1 error prohibited this user from being saved')
  end

  def sign_up_with(name, email, password)
    visit new_user_registration_path
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
  end
end
  
feature 'John logs in' do
  scenario 'with valid email and password' do
    sign_in 'john@example.com', 'password'

    expect(page).to have_content('Logout John')
  end

  def sign_in(email, password)
    # user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end

feature 'John creates ticket' do
  scenario 'using valid data' do
    
  end
end
  
  
  
  
  
  
  
  
  
  
  