require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  context '#word_search' do
    it 'and find a power generator by name' do
      generator = create(:power_generator, name: 'PLACA SOLAR DE TESTES')

      result = PowerGenerator.word_search('placa solar de testes')

      expect(result).to include(generator)
    end

    it 'and find a power generator by description' do
      generator = create(:power_generator, description: 'Placa solar utilizada'\
        ' para testes')

      result = PowerGenerator.word_search('utilizada para teste')

      expect(result).to include(generator)
    end

    it 'and order by name' do
      generator_last = create(:power_generator, name: 'Placa solar de teste: X')
      generator_first = create(:power_generator, name: 'Placa solar de teste: A')
      create(:power_generator, name: 'Placa solar de teste: G')

      result = PowerGenerator.word_search('Placa solar de teste')

      expect(result.first).to eq(generator_first)
      expect(result.last).to eq(generator_last)
    end

    it 'and order by name and price' do
      generate_last = create(:power_generator, name: 'Placa solar de teste: X',
                                               price: 25000)
      generate_first = create(:power_generator, name: 'Placa solar de teste: A',
                                                price: 50000)
      create(:power_generator, name: 'Placa solar de teste: G', price: 75000)
      generate_second = create(:power_generator, name: 'Placa solar de teste: G', 
                                                 price: 61900)

      result = PowerGenerator.word_search('Placa solar de teste')

      expect(result.first).to eq(generate_first)
      expect(result.second).to eq(generate_second)
      expect(result.last).to eq(generate_last)
    end
  end
end
