class Ticket < ApplicationRecord
	validates :name, :description, presence: true	
	validates :description, length: { minimum: 10, maximum: 1000 }
end
