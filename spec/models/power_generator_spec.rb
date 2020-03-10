require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  context '#name_description_search' do
    it 'and find a power generator by name' do
      generator = create(:power_generator, name: 'PLACA SOLAR DE TESTES')

      result = PowerGenerator.name_description_search('placa solar de testes')

      expect(result).to include(generator)
    end

    it 'and find a power generator by description' do
      generator = create(:power_generator, description: 'Placa solar utilizada'\
        ' para testes')

      result = PowerGenerator.name_description_search('utilizada para teste')

      expect(result).to include(generator)
    end
  end

  context '.calculate_cubage' do
    context 'on create' do
      it 'successfully' do
        generator = create(:power_generator, height: 1.2, width: 0.2, lenght: 1.8)

        expect(generator.cubage).to eq(129.6)
      end

      it 'and have height, width and lenght with zero' do
        generator = create(:power_generator, height: 0, width: 0, lenght: 0)

        expect(generator.cubage).to eq(0)
      end
    end

    context 'on update' do
      it 'successfully' do
        generator = create(:power_generator, height: 1.2, width: 0.2, lenght: 1.8)
        generator.update!(height: 1.8, width: 1.2, lenght: 1.4)

        expect(generator.cubage).to eq(907.2)
      end

      it 'and have height, width and lenght with zero' do
        generator = create(:power_generator, height: 1.2, width: 0.2, lenght: 1.8)
        generator.update!(height: 0, width: 0, lenght: 0)

        expect(generator.cubage.to_f).to eq(0)
      end
    end
  end

  context '.lowest_weight' do
    it 'weight heavier than cubage' do
      generator = PowerGenerator.new(weight: 150, cubage: 120)

      expect(generator.lowest_weight).to eq(120)
    end

    it 'cubage heavier than weight' do 
      generator = PowerGenerator.new(weight: 85, cubage: 215)

      expect(generator.lowest_weight).to eq(85)
    end
  end
end
