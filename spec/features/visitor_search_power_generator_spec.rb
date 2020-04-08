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
      fill_in 'o que procura?', with: 'Placa solar grande'
      click_on 'Pesquisar'

      expect(page).to have_content('Placa solar grande')
      expect(page).to have_content('Placa solar grande para telhados')

      expect(page).to_not have_content('Placa solar pequena')
      expect(page).to_not have_content('Placa solar pequena para telhados')
    end

    scenario 'and not fill a search filter' do
      visit root_path
      page.find(:css, '#simpleSearch').set(true)
      fill_in 'o que procura?', with: ''
      click_on 'Pesquisar'

      expect(current_path).to eq(simple_search_power_generators_path)
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

  xcontext 'in a advanced query' do
    scenario 'successfully' do
      create(:power_generator, manufacturer: 'NeoSolar')
      create(:power_generator, manufacturer: 'Ourolux Solar')

      visit root_path

      choose('Pesquisa Avançada')

      fill_in placeholder: 'Fabricante', with: 'NeoSolar'

      click_on 'Pesquisar'

      expect(page).to have_content('NeoSolar')
      expect(page).to_not have_content('Ourolux Solar')
    end
  end
end
