# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  test 'valid login path' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: 'valid@gmail.com', password: 'Hung123456' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  test 'login with valid email/invalid password' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: 'hung123123@gmail.com', password: 'invalid' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'valid login information' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'Hung123456' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
