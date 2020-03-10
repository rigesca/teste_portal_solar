require 'rails_helper'

feature 'Visitor calculate freight' do
  scenario 'successfully' do
    generator = create(:power_generator, name: 'A - Placa solar grande',
                                         weight: 30)
    create(:freight, state: 'SP',
                     weight_min: 20,
                     weight_max: 50,
                     cost: 50)
    create(:freight, state: 'SP',
                     weight_min: 40,
                     weight_max: 60,
                     cost: 67)

    visit root_path
    click_on generator.name.upcase

    fill_in 'CEP', with: '04296-000'
    click_on 'Calcula Frete'

    expect(page).to have_content('SP')
    expect(page).to have_content('Valor do Frete: R$ 50,00')
    expect(page).not_to have_content('Valor do Frete: R$ 67,00')
  end

  scenario 'and consults freight table' do
    generator = create(:power_generator, name: 'A - Placa solar grande',
                                         weight: 30)
    create(:freight, state: 'SP',
                     weight_min: 20,
                     weight_max: 50,
                     cost: 50)
    create(:freight, state: 'SP',
                     weight_min: 40,
                     weight_max: 60,
                     cost: 67)

    visit root_path
    click_on generator.name.upcase

    fill_in 'CEP', with: '04296-000'
    click_on 'Calcula Frete'

    click_on 'Consulta Tabela de Frete'

    expect(page).to have_content('04296000')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('Avenida Santo Albano')
    expect(page).to have_content('SP')

    expect(page).to have_content('20')
    expect(page).to have_content('50')
    expect(page).to have_content('R$ 50,00')

    expect(page).to have_content('40')
    expect(page).to have_content('60')
    expect(page).to have_content('R$ 67,00')
  end
end
