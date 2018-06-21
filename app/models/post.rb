class Post < ActiveRecord::Base
  #너는 user에 포함되어있어 :모델 연결 하는법
  belongs_to :user
end
