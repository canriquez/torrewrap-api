FactoryBot.define do
  factory :user do
    name { 'Carlos' }
    public_id { 'myuser' }
    password { '12345' }
    picture_thumbnail { 'url://' }
    video_url { 'url://' }
    json_response { '{}' }
  end
end
