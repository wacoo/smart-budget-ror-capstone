require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

RSpec.describe 'Splash', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'John', email: 'xyz@gmail.com', password: '123456', role: 'Admin')
  end

  before do
    @user2 = User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456')
    @group1 = Group.create(name: 'Morgage', user: user1)
    @group2 = Group.new(name: 'Transport', user: user1)
    @group1.icon.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'mo.png')),
      filename: 'mo.png',
      content_type: 'image/png'
    )
    @group2.icon.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'fuel.png')),
      filename: 'fuel.png',
      content_type: 'image/png'
    )
    @group1.save
    @group2.save
  end

  context 'splash' do
    scenario 'should show login link' do
      visit '/splash'
      expect(page).to have_content('LOG IN')
    end

    scenario 'should show signup link' do
      visit '/splash'
      expect(page).to have_content('SIGN UP')
    end

    scenario 'should should login successfully' do
      visit '/splash'
      click_link 'LOG IN'
      sign_in(user1)
      expect(page).to have_content('Signed in successfully.')
    end
    scenario 'should should show register page' do
      visit '/splash'
      click_link 'SIGN UP'
      expect(page).to have_current_path('/users/sign_up')
    end
  end
end
