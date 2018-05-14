cp ./users.tem users.yml
for i in {1..99}
do
  echo "test_$i:" >> users.yml
  echo "  name: test_$i" >> users.yml
  echo "  email: test_$i@microhard.com" >> users.yml
  echo '  password_digest: $2a$04$HYBBIgtEmVulomTEBBWgF.KNphDuzyecu.d3e3bg8/OTkYcWFcQYq' >> users.yml
  echo "  activated: true" >> users.yml
  echo "  activated_at: Sun, 13 May 2018 14:09:02 UTC +00:00" >> users.yml
  echo "" >> users.yml
done
