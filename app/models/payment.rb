class Payment < ActiveRecord::Base
  belongs_to :payment_profile
  attr_accessible :amount, :student_id

  def student
    Contact.find(self.student_id).full_name
  end
end