namespace :create do
  task user: :environment do
    User.create(
      email: ENV['email'],
      password: ENV['password'],
      first_name: 'Mary',
      last_name: 'Poppins',
      role: 'registered'
    )
  end
end
