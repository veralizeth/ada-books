class Book < ApplicationRecord
  validates :title, presence: true,  uniqueness: true
  
  belongs_to :author
  has_and_belongs_to_many :genres
end
