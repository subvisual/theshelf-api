[![Code Climate](https://codeclimate.com/github/groupbuddies/theshelf.png)](https://codeclimate.com/github/groupbuddies/theshelf)
[![Build Status](https://travis-ci.org/votinginfoproject/ios7-white-label-app.svg?branch=develop)](https://travis-ci.org/votinginfoproject/ios7-white-label-app)

# The Shelf

## Setup

To install paste the following:

    curl https://raw.githubusercontent.com/groupbuddies/theshelf/master/scripts/install.sh | sh

### Create a user

There is a rake task to create a user using email and password.

    bundle exec rake create:user name=your-name password=your-password

The scripts gives you a default name, you can then change it on the platform.
