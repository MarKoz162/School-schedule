User.create(email: "example1@example.com", password: "qwe123", password_confirmation: "qwe123" )
User.create(email: "example2@example.com", password: "qwe123", password_confirmation: "qwe123" )
User.create(email: "example3@example.com", password: "qwe123", password_confirmation: "qwe123" )

User.update_all confirmed_at: DateTime.now