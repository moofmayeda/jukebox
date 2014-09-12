FactoryGirl.define do
  factory :user do
    email "moof@moof.com"
    password "password"
    password_confirmation "password"
    admin false
  end

  factory :admin, class: User do
    email "admin@admin.com"
    password "password"
    password_confirmation "password"
    admin true
  end

  factory :song do
    title "One More Hour"
    artist "Sleater Kinney"
    track_id 165374892
  end

  factory :review do
    title "Awesome!"
    text "It really is great"
  end
end
