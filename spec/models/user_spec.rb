require 'rails_helper'

describe User, 'authentication' do
  it 'should authenticate a valid user' do
    expect(User.authenticate('jordan', 'password')).to eq users(:jordan)
  end

  it 'should not authenticate valid user with wrong password' do
    expect(User.authenticate('jordan', 'wrong')).to be_nil
  end

  it 'should not authenticate valid user with nil password' do
    expect(User.authenticate('jordan', nil)).to be_nil
  end

  it 'should not authenticate with invalid user name' do
    expect(User.authenticate('invalid', 'anything')).to be_nil
  end

  it 'should not authenticate with nil user name' do
    expect(User.authenticate(nil, nil)).to be_nil
  end
end

describe User, 'validations' do
  it 'should have a name' do
    user = User.new
    user.valid?
    expect(user.errors[:name]).not_to be_empty
  end

  it 'should have a name with valid characters' do
    user = User.new name: 'INVALID'
    user.valid?
    expect(user.errors[:name]).not_to be_empty
  end

  it 'should have a password' do
    user = User.new
    user.valid?
    expect(user.errors[:password]).not_to be_empty
  end

  it 'should have a customer' do
    user = User.new
    user.valid?
    expect(user.errors[:customer]).not_to be_empty
  end

  it 'should have a unique name' do
    user = User.new name: users(:jordan).name
    user.valid?
    expect(user.errors[:name]).not_to be_empty
  end
end

describe User, 'status' do
  it 'follows customer cancelation' do
    user = users(:jordan)
    user.customer.cancel!

    expect(user.canceled?).to be(true)
  end

  it 'should count this month based on usage' do
    expect(users(:matt).site_count_this_month).to eq(15)
  end

  it 'should count last month based on usage' do
    expect(users(:matt).site_count_last_month).to eq(4)
  end
end