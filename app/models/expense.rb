class Expense < ActiveRecord::Base
	belongs_to :item
	scope :ordered, -> { order("day DESC") }
end
