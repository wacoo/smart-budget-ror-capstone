require 'rails_helper'

def sign_in(user)
  post user_session_path, params: { user: { email: user.email, password: user.password } }
end

RSpec.describe 'Expense', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    it 'should http status 200' do
      sign_in(user)
      get new_expense_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      get new_expense_path
      expect(response.body).to render_template('new')
    end

    it 'correct place holder text' do
      sign_in(user)
      get new_expense_path
      expect(response.body).to include('NEW EXPENSE')
    end
  end
end
