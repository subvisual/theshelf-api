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
read -p "Type the email: " email
read -s -p "Type the password: " password

printf "\nWaiting..."
bundle exec rake create:user email=$email password=$password

printf " done.\n"
printf "You can now run the server to start using TheShelf.\n"
