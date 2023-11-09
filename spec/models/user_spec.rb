require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do
    it 'should be valid with all required fields' do
      @user = User.new(name: 'Mia', email: 'miameows@aol.com', password: '1234abcd', password_confirmation: '1234abcd')
      expect(@user).to be_valid
    end

    it 'should not be valid when password and password_confirmation do not match' do
      @user = User.new(name: 'Mia', email: 'miameows@aol.com', password: '1234abcd', password_confirmation: 'abcd1234')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not be valid without a password' do
      @user = User.new(name: 'Mia', email: 'miameows@aol.com', password: nil, password_confirmation: '1234abcd')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not be valid without an email' do
      @user = User.new(name: 'Mia', password: '1234abcd', password_confirmation: '1234abcd')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not be valid without a name' do
      @user = User.new(name: nil, email: 'miameows@aol.com', password: '1234abcd', password_confirmation: '1234abcd')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not be valid with a non-unique email' do
      User.create(
        password: 'password',
        password_confirmation: 'password',
        email: 'test@test.com',
        name: 'John'
      )
      user = User.new(
        password: 'password',
        password_confirmation: 'password',
        email: 'TEST@TEST.com',
        name: 'Jane'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should be valid with a password of minimum length' do
      user = User.new(
        password: 'password1',
        password_confirmation: 'password1',
        email: 'test@test.com',
        name: 'Mia'
      )
      expect(user).to be_valid
    end

    it 'should not be valid with a password less than minimum length' do
      user = User.new(
        password: 'pass',
        password_confirmation: 'pass',
        email: 'test@test.com',
        name: 'Mia'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with valid email and password' do
      user = User.create(
        name: 'Mia',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
        )

      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with email containing spaces' do
      user = User.create(
        name: 'Mia',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with email in different case' do
      user = User.create(
        name: 'Mia',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials('tEsT@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
