class Todo < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 100 }
end
