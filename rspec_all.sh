echo "-------------------"
echo "helper spec"
bundle exec rspec --format p --format html --out doc/result/helper/experiences_helper_spec_result.html spec/helpers/experiences_helper_spec.rb

echo "-------------------"
echo "model spec"
bundle exec rspec --format p --format html --out doc/result/model/experience_tag_spec_result.html spec/models/experience_tag_spec.rb
bundle exec rspec --format p --format html --out doc/result/model/notice_spec_result.html spec/models/notice_spec.rb
bundle exec rspec --format p --format html --out doc/result/model/user_spec_result.html spec/models/user_spec.rb

echo "-------------------"
echo "system spec"
DIR=./spec/system
for pathfile in $DIR/*.rb; do
  file_name=`basename $pathfile | sed -r 's/([a-z_]+).rb/\1/'`
  bundle exec rspec --format p --format html --out doc/result/system/${file_name}_result.html $pathfile
done