DIR=./spec/system
for pathfile in $DIR/*.rb; do
  file_name=`basename $pathfile`
  bundle exec rspec --format p --format html --out doc/result/${file_name}_result.html $pathfile
done