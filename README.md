The Shelf API
=============

[![Build Status](https://semaphoreci.com/api/v1/projects/4a69615e-1be7-4548-a872-5b135a65891c/368224/badge.png)](https://semaphoreci.com/groupbuddies/theshelf-api)

This is a fork of [The Shelf](https://github.com/groupbuddies/theshelf). In the fork we made The Shelf a Rails api, you can vistit [theshelf-angular](https://github.com/groupbuddies/theshelf-angular) for a client.

The Shelf is an online library for small companies to keep track of their books, encourage reading and to create discussion around knowledge. It has been developed as an internal tool by Group Buddies.

### Create a user

There is a rake task to create a user using email and password.

```
bundle exec rake create:user email=your-email first_name=Gabriel last_name=Poça password=your-password
```

If you need to change something you can always use a web interface.

## Going Live

If you're going live the The Shelf on your company or book club then you should let us know!

## Features

* Add books to your company's shelf
* Search a book by its name and author
* Borrow/Return books
* Comment & rate a book
* Edit your profile information

## Development

To run The Shelf you need Ruby 2.2.0.

```
bundle install
rake db:create && rake db:migrate && rake db:seed
```
