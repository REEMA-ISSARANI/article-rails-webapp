class Article < ActiveRecord::Base

	has_many :likes, class_name: 'Like', dependent: :destroy

	has_many :articles, dependent: :destroy

	belongs_to :user

	validates :title, presence: true, length: { minimum: 5 } 
end
