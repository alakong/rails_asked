class User < ActiveRecord::Base
  has_secure_password
  #너는 게시글들을 많이 들고 있어
  has_many :posts
end
