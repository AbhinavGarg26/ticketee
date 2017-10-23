class Ticket < ApplicationRecord
	belongs_to :project
	belongs_to :state, optional: true
	belongs_to :author, class_name: "User"
	has_many :attachments, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :tags, uniq: true
	attr_accessor :tag_names
	accepts_nested_attributes_for :attachments, reject_if: :all_blank	

	validates :name, :description, presence: true	
	validates :description, length: { minimum: 10, maximum: 1000 }

	before_validation :assign_default_state

	def tag_names=(names)
		@tag_names = names
		names.split.each do |name|
			self.tags << Tag.find_or_initialize_by(name: name)
		end
	end

	private

	def assign_default_state
		self.state ||= State.default
	end

end
