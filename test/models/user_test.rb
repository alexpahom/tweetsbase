require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: 'wafflewitch',
      first_name: 'Stan',
      last_name: 'Kubrik',
      email: 'admin@example.com',
      phone: '8-033-100-201-223',
      password: 'password'
    )
  end

  test 'Valid user creation' do
    assert @user.valid?
  end

  test 'Username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'Last name should be present' do
    @user.last_name = ''
    assert_not @user.valid?
  end

  test 'First name should be present' do
    @user.first_name = ''
    assert_not @user.valid?
  end

  test 'Email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'Username should be unique' do
    @user.save
    user = @user.dup
    user.email = 'test@example.com'
    assert_not user.valid?
  end

  test 'Email should be unique' do
    @user.save
    user = @user.dup
    user.username = 'kanyewest'
    assert_not user.valid?
  end

  test 'Email should have proper format' do
    valid_addresses = %w(user@example.com US%ER@example.ru us.er@example.by user@exam.ple.org)
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end

    invalid_addresses = %w(user@example,com user.com
        user@example user@ex+ample.ru user@ex_ample.com)
    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test 'Username should not be long' do
    @user.username = 'qqqq-wwww-eeee-rrrr-t'
    assert_not @user.valid?
  end

  test 'First name should not be long' do
    @user.first_name = 'qqqq-wwww-eeee-rrrr-t'
    assert_not @user.valid?
  end

  test 'Last name should not be long' do
    @user.last_name = 'qqqq-wwww-eeee-rrrr-t'
    assert_not @user.valid?
  end

  test 'Email should not be long' do
    @user.email = 'qqqq.wwww.eeee@rr.com'
    assert_not @user.valid?
  end

  test 'Email is case insensitive' do
    @user.save
    user = @user.dup
    user.email.upcase
    assert_not user.valid?
  end

  test 'User should have the password' do
    @user.password_digest = ''
    assert_not @user.valid?
  end

  test 'Password should not be short' do
    @user.password = 'pass'
    assert_not @user.valid?
  end
end
