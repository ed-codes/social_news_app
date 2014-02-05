class Post < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user
end
