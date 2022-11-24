class User < ApplicationRecord
  has_secure_password
  
  enum role: %i[admin member guest]
  validates_uniqueness_of :email
  validates_presence_of :email, :password
end
