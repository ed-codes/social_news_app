class Vote < ActiveRecord::Base
  validates :user_id, uniqueness: {scope: :post}
  # {:message => "You have already voted"} , :scope => {:post}
  belongs_to :post
  belongs_to :user
end
