# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get sign_up_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get sign_up_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'test',
                                         email: 'hungtest@gmail.com',
                                         password: 'Hung123456',
                                         password_confirmation: 'Hung123456' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert logged_in?
  end
end
