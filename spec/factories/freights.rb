FactoryBot.define do
  factory :freight do
    state { 'SP' }
    weight_min { 100 }
    weight_max { 150 }
    cost { 59.99 }
  end
end
