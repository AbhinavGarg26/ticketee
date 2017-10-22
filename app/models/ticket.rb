class Ticket < ApplicationRecord
	belongs_to :project
	belongs_to :state, optional: true
	belongs_to :author, class_name: "User"
	has_many :attachments, dependent: :destroy
	has_many :comments, dependent: :destroy
	accepts_nested_attributes_for :attachments, reject_if: :all_blank	

	validates :name, :description, presence: true	
	validates :description, length: { minimum: 10, maximum: 1000 }

	before_validation :assign_default_state

	private

	def assign_default_state
		self.state ||= State.default
	end

end
