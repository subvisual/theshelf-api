echo 'Cloning TheShelf'
git clone git@github.com:groupbuddies/theshelf.git || {
  echo 'git not installed'
  exit
}
