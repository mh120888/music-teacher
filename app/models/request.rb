class Request < ActiveRecord::Base
	attr_accessible :description, :title
	belongs_to :contact

  def contact_name
    Contact.find(self.contact_id).full_name
  end
end