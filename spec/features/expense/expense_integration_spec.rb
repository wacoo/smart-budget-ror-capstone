require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

RSpec.describe 'Expense', type: :system do
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

  context 'new' do
    scenario 'should show expense names' do
      sign_in(user1)
      visit new_expense_path
      fill_in 'Name', with: 'Bread'
      fill_in 'Amount', with: 5
      select 'Morgage', from: 'expense[group_ids]'
      click_button 'ADD EXPENSE'
      expect(page).to have_content('Expense created successfully.')
    end

    scenario 'should show labels' do
      sign_in(user1)
      visit new_expense_path
      expect(page).to have_content('Name')
      expect(page).to have_content('Amount')
      expect(page).to have_content('Group ids')
    end

    scenario 'should show submit button' do
      sign_in(user1)
      visit new_expense_path
      expect(page).to have_content('NEW EXPENSE')
    end
  end
end
