class User < ApplicationRecord
  #will run this and convert email to lowercase before saving to DB
  before_save {self.email = email.downcase}
  has_many :articles
 #constant in ruby (all caps)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username,
             presence: true,
             uniqueness: {case_sensitive: false},
             length: {minimum:3, maximum:25}
  validates :email,
             presence: true, uniqueness: {case_sensitive: false},
             length: {maximum: 100},
             format: {with: VALID_EMAIL_REGEX}
end
