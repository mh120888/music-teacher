users = [
  {name: 'Andy Lee', email: 'andy@example.com'},
  {name: 'Eli Shkurkin', email:'eli@example.com'}
]

users.each do |params| 
  user = User.new(params)
  user.password = 'password'
  user.save
end

student_contacts = [
  {first_name: 'Kevin', last_name: 'Yeh', email:'kevin@example.com', address: '101 Main Street, Berkeley, CA', phone:'999-555-1234'},
  {first_name: 'Matt', last_name: 'Higgins', email:'matt@example.com', address: '102 Main Street, Berkeley, CA', phone:'810-555-1239'}
]

user = User.where('name=?', 'Andy Lee').first

student_contacts.each do |params| 
  contact = Contact.new(params)
  user.contacts << contact
  contact.save
end