User.create(email: "example1@example.com", password: "qwe123", password_confirmation: "qwe123" )
User.create(email: "example2@example.com", password: "qwe123", password_confirmation: "qwe123" )
User.create(email: "example3@example.com", password: "qwe123", password_confirmation: "qwe123" )

User.update_all confirmed_at: DateTime.now


Classroom.create(name: "Room1")
Classroom.create(name: "Room2")
Classroom.create(name: "Room3")

Service.create(name: "Math", duration: 45 , client_price: 0)
Service.create(name: "aaaa", duration: 45 , client_price: 0)
Service.create(name: "dddd", duration: 45 , client_price: 0)
