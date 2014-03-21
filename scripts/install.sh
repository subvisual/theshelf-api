DEFAULT_EMAIL="me@me.com"
DEFAULT_PASSWORD="12345"
FOLDER="theshelf"
readonly FOLDER

git clone git@github.com:groupbuddies/theshelf.git $FOLDER || {
  printf "git not installed\n"
  exit
}

cd $FOLDER

printf "Bundle install...\n"
bundle install --quiet

printf "Database setup...\n"
bundle exec rake db:migrate VERBOSE=false

printf "To create a first user run \"bundle exec rake create:user email=your-email password=your-password\" inside the folder\n"
