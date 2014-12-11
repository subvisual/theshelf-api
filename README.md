#The Shelf

[![Code Climate](https://codeclimate.com/github/groupbuddies/theshelf.png)](https://codeclimate.com/github/groupbuddies/theshelf)
[![Build Status](https://semaphoreapp.com/api/v1/projects/a61e8b4f-975e-48fc-bd8e-f897ba004f71/308322/shields_badge.svg)](https://semaphoreapp.com/groupbuddies/theshelf)

The Shelf is an online library for small companies to keep track of their books, encourage reading and to create discussion around knowledge. It has been developed as an internal tool by Group Buddies.


## Setup

To install paste the following:

    curl -L https://raw.githubusercontent.com/groupbuddies/theshelf/master/scripts/install.sh | sh

### Create a user

There is a rake task to create a user using email and password.

    bundle exec rake create:user name=your-name password=your-password

The scripts gives you a default name, you can change it later on the web interface.


## Going Live

If you're going live the The Shelf on your company or book club then you should let us know!

## Features

* Add books to your company's shelf
* Search a book by its name and author
* Borrow/Return books
* Comment & rate a book
* Edit your profile information
