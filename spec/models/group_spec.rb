require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
  subject do
    Group.new(name: 'Transport', icon: nil, user:)
  end

  before do
    user.save
    subject.save
  end

  it('empty name should not be valid') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('name should be valid') do
    subject.name = 'Alamony'
    expect(subject).to be_valid
  end
end
