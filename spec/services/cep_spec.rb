require 'rails_helper'

RSpec.describe Cep do
  context '#find' do
    it 'valid zipcode with dash' do
      address = Cep.find('45089-680')

      expect(address[:state]).to eq('BA')
      expect(address[:zipcode]).to eq('45089680')
      expect(address[:address]).to eq('Rua do Canela')
      expect(address[:city]).to eq('Vitória da Conquista')
    end

    it 'valid zipcode without dash' do
      address = Cep.find('68550854')

      expect(address[:state]).to eq('PA')
      expect(address[:zipcode]).to eq('68550854')
      expect(address[:address]).to eq('Avenida Dois')
      expect(address[:city]).to eq('Redenção')
    end

    it 'invalid zipcode' do
      address = Cep.find('11111111')

      expect(address).to be_empty
    end

    it 'empty zipcode' do
      address = Cep.find(nil)

      expect(address).to be_empty
    end

    it 'bigger zipcode' do
      address = Cep.find('78117422888')

      expect(address).to be_empty
    end

    it 'smaller zipcode' do 
      address = Cep.find('22458')

      expect(address).to be_empty
    end
  end
end
