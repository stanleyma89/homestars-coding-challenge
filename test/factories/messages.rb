FactoryBot.define do
  factory :message do
    content { "Russell Wilson is the best QB of all time" }
    user_id { 1 }
    channel_id { 2 }
  end
end
