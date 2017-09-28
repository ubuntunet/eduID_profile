require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid user" do
    user = users(:dave)
    assert user.valid?
  end

  test "invalid without username" do
    user = User.new(email: 'john@examle.net', password: 'secret')
    refute user.valid?, 'user is valid without a username'
    assert_not_nil user.errors[:username], 'no validation error for username present'
  end

  test "invalid without email" do
    user = User.new(username: 'john', password: 'secret', affiliation: 'member')
    refute user.valid?, 'user is valid without an email'
    assert_not_nil user.errors[:email], 'no validation error for email present'
  end

  test "invalid without password" do
    user = User.new(username: 'john', email: 'secret', affiliation: 'member')
    refute user.valid?, 'user is valid without a password'
    assert_not_nil user.errors[:password], 'no validation error for password present'
  end

  test "invalid without affiliation" do
    user = User.new(username: 'john', password: 'secret', email: 'john@example.ac.net')
    refute user.valid?, 'user is valid without an affiliation'
    assert_not_nil user.errors[:affiliation], 'no validation error for affiliation present'
  end

  test "invalid with unknown affiliation" do
    user = User.new(username: 'john', password: 'secret', email: 'john@example.ac.net', affiliation: 'staff')
    refute user.valid?, 'user is valid with unspecified affiliation'
    assert_not_nil user.errors[:affiliation], 'no validation error for affiliation present'
  end

  test "invalid with already existing username" do
    existing_user = users(:dave)
    user = User.new(username: 'daveh', password: 'secret', email: 'john@example.ac.net', affiliation: 'staff')
    refute user.valid?, 'user is valid with non-unique username'
    assert_not_nil user.errors[:username], 'no validation error for username present'
  end

end
