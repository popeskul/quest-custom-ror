Staff.create(email: 'admin@mail.com', password: '123123')
Staff.create(email: 'super-admin@mail.com', password: '123123', role: 'super_admin')

User.create(email: 'user@mail.com', password: '123123')
User.create(email: 'user2@mail.com', password: '123123')

user = User.first
user2 = User.find_by(email: 'user2@mail.com')
staff = Staff.first

Event.create!(
  title: 'title staff 1', description: 'description 1',
  location: 'location 1', organizer_email: 'admin@mail.com',
  start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
  event_postable: staff
)
Event.create!(
  title: 'title user 1', description: 'description 1',
  location: 'location 1', organizer_email: 'admin@mail.com',
  start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
  event_postable: user
)

Event.create!(
  title: 'title user 2', description: 'description 2',
  location: 'location 2', organizer_email: 'admin@mail.com',
  start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
  event_postable: user2
)
