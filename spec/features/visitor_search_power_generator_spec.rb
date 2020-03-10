require 'rails_helper'

feature 'Visitor search for a power generator' do
  context 'in a simple query' do
    scenario 'successfully' do
      create(:power_generator, name: 'Placa solar grande',
                               description: 'Placa solar grande para telhados')
      create(:power_generator, name: 'Placa solar pequena',
                               description: 'Placa solar pequena para telhados')

      visit root_path
      page.find(:css, '#simpleSearch').set(true)
      fill_in 'o que procura?', with: 'Grande'
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

  context 'in a advanced query' do
    scenario 'successfully' do
      create(:power_generator, manufacturer: 'NeoSolar')
      create(:power_generator, manufacturer: 'Ourolux Solar')

      visit root_path
      #byebug
      page.find(:css, '#simpleSearch').set(true)

      page.find("input[placeholder='Fabricante']").set 'NeoSolar'

      click_on 'Pesquisar'

      expect(page).to have_content('NeoSolar')
      expect(page).to_not have_content('Ourolux Solar')
    end
  end
end
