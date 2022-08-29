class User < ApplicationRecord
  has_secure_password
  
  enum role: %i[admin member guest]
end
