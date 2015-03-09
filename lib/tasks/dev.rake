namespace :create do
  task user: :environment do
    User.create(
      email: ENV['email'],
      password: ENV['password'],
      first_name: ENV['first_name'],
      last_name: ENV['last_name'],
      role: 'registered'
    )
  end
end
