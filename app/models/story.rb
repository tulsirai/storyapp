class Story < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :comments

	acts_as_votable

	def self.scariest
		order(cached_votes_score: :desc).limit(5)
	end

	def self.random
		limit(5).order("RANDOM()")
	end

	def self.search(params)
		stories = Story.where("body LIKE ?", "%#{params[:search]}%") if params[:search].present?
		stories
	end
end