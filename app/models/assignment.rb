class Assignment < ActiveRecord::Base
	attr_accessible :description, :content, :title
	has_attached_file :content
	validates_attachment_content_type :content, :content_type => ['application/pdf',
	 'application/msword',
	  'text/plain',
	  'audio/mp3',
	  'application/x-mp3']
	belongs_to :contact

  def contact_name
    Contact.find(self.contact_id).full_name
  end
end