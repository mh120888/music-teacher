module AssignmentsHelper
  def contact_name
    Contact.find(self.contact_id).full_name
  end
end