require 'rails_helper'

def sign_in(user)
  post user_session_path, params: { user: { email: user.email, password: user.password } }
end

RSpec.describe 'Group', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:group) do
      Group.new(name: 'Transport', icon: nil, user:)
    end
    it 'should http status 200' do
      sign_in(user)
      get groups_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      get groups_path
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      sign_in(user)
      get groups_path
      expect(response.body).to include('CATEGORIES')
    end
  end
  describe 'GET #show' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:group) { Group.create(name: 'Transport', user:) }

    it 'should have HTTP status 200' do
      sign_in(user)
      icon_file = fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'logo.png'), 'image/png')

      group.icon.attach(io: File.open(icon_file), filename: 'logo.png', content_type: 'image/png')

      get group_path(group.id)
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      icon_file = fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'logo.png'), 'image/png')
      group.icon.attach(io: File.open(icon_file), filename: 'logo.png', content_type: 'image/png')
      get groups_path(group.id)
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      sign_in(user)
      icon_file = fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'logo.png'), 'image/png')
      group.icon.attach(io: File.open(icon_file), filename: 'logo.png', content_type: 'image/png')
      get group_path(group)
      expect(response.body).to include('EXPENSES')
    end
  end
  describe 'GET #new' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:group) { Group.create(name: 'Transport', user:) }
    it 'should http status 200' do
      sign_in(user)
      get new_group_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      get new_group_path
      expect(response.body).to render_template('new')
    end

    it 'correct place holder text' do
      sign_in(user)
      get new_group_path
      expect(response.body).to include('NEW CATEGORY')
    end
  end
end
