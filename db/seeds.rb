users = [
  {name: 'Andy Lee', password: 'password', email: 'andy@example.com'},
  {name: 'Eli Shkurkin', password: 'password', email:'eli@example.com'}
]

users.each { |params| User.create(params) }

student_contacts = [
  
]