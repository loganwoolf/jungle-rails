class Category < ActiveRecord::Base

  has_many :products

  validates :name, length: { in: 4..32 }
  validates :name, format: { with: /\A[a-zA-Z][a-z A-Z]+[a-zA-Z]\z/,
    message: "can only be letters with spaces between" }
end
