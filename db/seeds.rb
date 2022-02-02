# Create users
staff, _ = Staff.create!([
                           { email: "admin@mail.com", password: "123123" },
                           { email: "super-admin@mail.com", password: "123123", role: "super_admin" }
                         ])

user, user2 = User.create!([
                             { email: "user@mail.com", password: "123123" },
                             { email: "user2@mail.com", password: "123123" }
                           ])

# Create tags
movie_tag = Tags::Services::CreateTag.new(name: "art", keys: "banksy, warhol").call
music_tag = Tags::Services::CreateTag.new(name: "music", keys: "soad, metallica").call
dev_tag = Tags::Services::CreateTag.new(name: "development", keys: "ruby, backend, programming").call

# Create subscriptions by tags
TagSubscription.create!([
                          { email: user.email, tags: [movie_tag.name, music_tag.name] },
                          { email: user2.email, tags: [dev_tag.name] }
                        ])

# Create Events
event1, event2 = Event.create!([
                                 {
                                   title: "Movie and music tags", description: "movie and music description as staff role",
                                   location: "location 1", organizer_email: "admin@mail.com",
                                   start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
                                   event_postable: staff,
                                   tag_list: [movie_tag, music_tag]
                                 },
                                 {
                                   title: "Movie title", description: "movie description with the movie tag as user role",
                                   location: "location 1", organizer_email: "admin@mail.com",
                                   start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
                                   event_postable: user,
                                   tag_list: [movie_tag]
                                 },
                                 {
                                   title: "Ruby title", description: "ruby description with the dev tag as user role",
                                   location: "location 2", organizer_email: "admin@mail.com",
                                   start_time: Date.new(2001, 2, 3), end_time: Date.new(2001, 2, 3),
                                   event_postable: user2,
                                   tag_list: [dev_tag]
                                 }
                               ])

# approving an event
event1.approve!
event2.decline!
