require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
  before { subject.save }

  it('empty name should not be valid') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('empty email should not be vaid') do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it('name should be valid') do
    subject.name = 'John'
    expect(subject).to be_valid
  end

  it('email should be valid') do
    subject.email = 'xyz@gmail.com'
    expect(subject).to be_valid
  end
end
