require 'rails_helper'

feature 'Visitor search for a power generator' do
  context 'in a simple query' do
    scenario 'successfully' do
      create(:power_generator, name: 'Placa solar grande',
                               description: 'Placa solar grande para telhados')
      create(:power_generator, name: 'Placa solar pequena',
                               description: 'Placa solar pequena para telhados')

      visit root_path
      fill_in 'o que procura?', with: 'grande'
      click_on 'Pesquisar'

      expect(page).to have_content('Placa solar grande')
      expect(page).to have_content('Placa solar grande para telhados')

      expect(page).to_not have_content('Placa solar pequena')
      expect(page).to_not have_content('Placa solar pequena para telhados')
    end

    scenario 'and not find any power generators' do
      create(:power_generator, name: 'Placa solar grande',
                               description: 'Placa solar grande para telhados')
      create(:power_generator, name: 'Placa solar pequena',
                               description: 'Placa solar pequena para telhados')
      
      visit root_path
      fill_in 'o que procura?', with: 'industrial'
      click_on 'Pesquisar'

      expect(page).to have_content('Nenhum produto encontrado!')
    end
  end
end
