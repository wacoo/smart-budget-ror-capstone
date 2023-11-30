require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
  subject do
    Expense.new(name: 'Train', amount: 2, author: user)
  end

  before do
    user.save
    subject.save
  end

  it('empty name should not be valid') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('empty amount should not be valid') do
    subject.amount = nil
    expect(subject).not_to be_valid
  end

  it('negative amount should not be valid') do
    subject.amount = -3
    expect(subject).not_to be_valid
  end
end
