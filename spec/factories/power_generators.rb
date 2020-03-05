FactoryBot.define do
  factory :power_generator do
    name { 'TRIFÁSICO 380V' }
    description { '3 MPPTs para adaptação versáteis a diferentes tipos ou'\
                  'quantidades de módulos construídos com diferentes'\
                  'alinhamentos.' }
    image_url { 'https://marketplace-img-production.s3.amazonaws.com/products/13384/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546436139' }
    manufacturer { 'WEG' }
    structure_type { %i[metalico ceramico fibrocimento laje solo trapezoidal].sample }
    price { 52990.00 }
    height { 2 }
    width { 0.15 }
    lenght { 1.8 }
    weight { 218 }
    kwp { 23.14 }
  end
end
