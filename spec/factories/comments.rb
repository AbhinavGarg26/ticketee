FactoryGirl.define do
  factory :comment do
    text "MyText"
    ticket nil
    author nil
    state
  end
end
