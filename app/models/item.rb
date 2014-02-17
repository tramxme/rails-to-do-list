class Item < ActiveRecord::Base
  belongs_to :user
  validates :description, presence: true, length: {minimum: 10, maximum: 50}
  validates :user, presence: true

end
