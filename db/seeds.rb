user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

mockUsers = [
  {
    id: 1,
    email: "janet.doezer@gmail.com"
  },
  {
    id: 2,
    email: "john.smithy@gmail.com"
  },
  {
    id: 3,
    email: "alex.jordan@gmail.com"
  },
  {
    id: 4,
    email: "samantha.bright@gmail.com"
  },
  {
    id: 5,
    email: "michael.reyes@gmail.com"
  },
  {
    id: 6,
    email: "lisa.ray@gmail.com"
  },
  {
    id: 7,
    email: "david.green@gmail.com"
  },
  {
    id: 8,
    email: "sarah.connor@gmail.com"
  },
  {
    id: 9,
    email: "brian.hall@gmail.com"
  },
  {
    id: 10,
    email: "olivia.miles@gmail.com"
  }
]
