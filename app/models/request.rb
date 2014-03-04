class Request < ActiveRecord::Base
	attr_accessible :description, :title
	belongs_to :contact
end