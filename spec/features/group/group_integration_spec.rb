require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

RSpec.describe 'Group', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'John', email: 'xyz@gmail.com', password: '123456', role: 'Admin')
  end

  before do
    @user2 = User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456')
    @group1 = Group.new(name: 'Morgage', user: user1)
    @group2 = Group.new(name: 'Transport', user: user1)
    @expense = Expense.new(name: 'Train', amount: 2, author: user1)
    @expense2 = Expense.new(name: 'Rent', amount: 2000, author: user1)
    @group2.expenses << @expense
    @group1.expenses << @expense2
    # Attach icon files to the groups
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

  context 'index' do
    scenario 'should show food names' do
      sign_in(user1)
      visit groups_path
      expect(page).to have_content('Morgage')
      expect(page).to have_content('Transport')
    end

    scenario 'should show total expense' do
      sign_in(user1)
      visit groups_path
      expect(page).to have_content('$2002')
    end

    scenario 'should show group expenses' do
      sign_in(user1)
      visit groups_path
      expect(page).to have_content('$2')
      expect(page).to have_content('$2000')
    end

    scenario 'should show add category button' do
      visit groups_path
      sign_in(user1)
      expect(page).to have_content('+')
    end
  end

  context 'show' do
    scenario 'category page should have title' do
      sign_in(user1)
      visit group_path(@group1)
      expect(page).to have_content('EXPENSES')
    end

    scenario 'should have name' do
      sign_in(user1)
      visit group_path(@group1)
      expect(page).to have_content('Morgage')
    end

    scenario 'should have expense name' do
      sign_in(user1)
      visit group_path(@group1)
      expect(page).to have_content('Rent')
    end

    scenario 'should have expense' do
      sign_in(user1)
      visit group_path(@group1)
      expect(page).to have_content('$2000.0')
    end
  end

  context 'new' do
    scenario 'should have title' do
      sign_in(user1)
      visit new_group_path
      expect(page).to have_content('NEW CATEGORY')
    end

    scenario 'should have labels' do
      sign_in(user1)
      visit new_group_path
      expect(page).to have_content('Name')
      expect(page).to have_content('Icon')
    end
  end
end
