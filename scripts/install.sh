FOLDER="theshelf"
readonly FOLDER

git clone git@github.com:groupbuddies/theshelf.git $FOLDER || {
  echo "git not installed"
  exit
}

cd $FOLDER

printf "Bundle install...\n"
bundle install --quiet

printf "Database setup...\n"
bundle exec rake db:migrate VERBOSE=false

printf "Creating first user...\n"
printf "Type the email: "
read email
printf "Type the password: "
read -s password

printf "\nWaiting..."
bundle exec rake create:user email=$email password=$password

printf " done.\n"
printf "You can now run \'rails server\' to start using TheShelf."
