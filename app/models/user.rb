# frozen_string_literal: true

# dasdasda
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :microposts
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  # validates :password, presence: true, format: { with: /\A[A-Z]+[a-z]+[0-9]+/ }, length: { maximum: 58, minimum: 8 }
  has_secure_password
end
