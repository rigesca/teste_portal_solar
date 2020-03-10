require 'rails_helper'

RSpec.describe PowerGeneratorSearch do
  context '#simple_search' do
    it 'search for a generator by name' do
      create(:power_generator, name: 'Placa de teste')

      generator = PowerGeneratorSearch.simple_search('Placa de teste', 0)

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.count).to eq(1)
    end

    it 'search for a generator by description' do
      create(:power_generator, name: 'Placa de teste',
                               description: 'Bom e barato !')

      generator = PowerGeneratorSearch.simple_search('Bom e barato !', 0)

      expect(generator.first.description).to eq('Bom e barato !')
      expect(generator.count).to eq(1)
    end

    it 'organized by lowest price' do
      create(:power_generator, name: 'Placa de teste A',
                               price: 10000)
      create(:power_generator, name: 'Placa de teste B',
                               price: 999.00)

      generator = PowerGeneratorSearch.simple_search('Placa de teste', 1)

      expect(generator.first.name).to eq('Placa de teste B')
      expect(generator.second.name).to eq('Placa de teste A')
    end

    it 'organized by highest price' do
      create(:power_generator, name: 'Placa de teste A',
                               price: 10000)
      create(:power_generator, name: 'Placa de teste B',
                               price: 999.00)

      generator = PowerGeneratorSearch.simple_search('Placa de teste', 2)

      expect(generator.first.name).to eq('Placa de teste A')
      expect(generator.second.name).to eq('Placa de teste B')
    end

    it 'organized by lowest kwp' do
      create(:power_generator, name: 'Placa de teste A',
                               kwp: 9)
      create(:power_generator, name: 'Placa de teste B',
                               kwp: 12.5)

      generator = PowerGeneratorSearch.simple_search('Placa de teste', 3)

      expect(generator.first.name).to eq('Placa de teste A')
      expect(generator.second.name).to eq('Placa de teste B')
    end

    it 'organized by highest price' do
      create(:power_generator, name: 'Placa de teste A',
                               kwp: 9)
      create(:power_generator, name: 'Placa de teste B',
                               kwp: 12.5)

      generator = PowerGeneratorSearch.simple_search('Placa de teste', 4)

      expect(generator.first.name).to eq('Placa de teste B')
      expect(generator.second.name).to eq('Placa de teste A')
    end

    it 'default organization (by name)' do
      create(:power_generator, name: 'Placa de teste A')
      create(:power_generator, name: 'Placa de teste B')
      create(:power_generator, name: 'Placa de teste C')

      generator = PowerGeneratorSearch.simple_search('Placa de teste', nil)

      expect(generator.first.name).to eq('Placa de teste A')
      expect(generator.second.name).to eq('Placa de teste B')
      expect(generator.third.name).to eq('Placa de teste C')
    end
  end

  context '#advanced_search' do
    it 'search for manufacturer' do
      create(:power_generator, name: 'Placa de teste',
                               manufacturer: 'SOL')

      generator = PowerGeneratorSearch.advanced_search(manufacturer: 'SOL')

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.manufacturer).to eq('SOL')
      expect(generator.count).to eq(1)
    end

    it 'search for structure_type' do
      create(:power_generator, name: 'Placa de teste',
                               manufacturer: 'SOL',
                               structure_type: :laje)

      generator = PowerGeneratorSearch.advanced_search(
        manufacturer: 'SOL',
        structure_type: ['laje']
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.structure_type).to eq('laje')
      expect(generator.count).to eq(1)
    end

    it 'search for kwp range' do
      create(:power_generator, name: 'Placa de teste',
                               kwp: 55.9)

      generator = PowerGeneratorSearch.advanced_search(
        kwp_min: 50,
        kwp_max: 60
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.kwp).to eq(55.9)
      expect(generator.count).to eq(1)
    end

    it 'search for height range' do
      create(:power_generator, name: 'Placa de teste',
                               height: 22)

      generator = PowerGeneratorSearch.advanced_search(
        height_min: 12,
        height_max: 25
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.height).to eq(22)
      expect(generator.count).to eq(1)
    end

    it 'search for width range' do
      create(:power_generator, name: 'Placa de teste',
                               width: 25)

      generator = PowerGeneratorSearch.advanced_search(
        width_min: 19,
        width_max: 28
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.width).to eq(25)
      expect(generator.count).to eq(1)
    end

    it 'search for leght range' do
      create(:power_generator, name: 'Placa de teste',
                               leght: 32)

      generator = PowerGeneratorSearch.advanced_search(
        width_min: 22,
        width_max: 37
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.leght).to eq(32)
      expect(generator.count).to eq(1)
    end

    it 'search for weight range' do
      create(:power_generator, name: 'Placa de teste',
                               weight: 450.9)

      generator = PowerGeneratorSearch.advanced_search(
        weight_min: 440,
        weight_max: 657
      )

      expect(generator.first.name).to eq('Placa de teste')
      expect(generator.first.weight).to eq(450.9)
      expect(generator.count).to eq(1)
    end
  end
end
