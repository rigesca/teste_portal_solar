require 'rails_helper'

feature 'Visitor consult a power generator' do
  scenario 'successfully' do
    generator = create(:power_generator, name: 'Placa solar')

    visit root_path
    click_on generator.name.upcase

    expect(current_path).to eq(power_generator_path(generator))

    expect(page).to have_content(generator.name.upcase)
    expect(page).to have_content(generator.description)
    expect(page).to have_content(generator.manufacturer)
    expect(page).to have_content(generator.structure_type)
    expect(page).to have_content(
      number_to_currency(generator.price, unit: 'R$ ',
                                                precision: 2,
                                                :separator => ',',
                                                :delimiter => '.')
    )
    expect(page).to have_content(generator.height)
    expect(page).to have_content(generator.width)
    expect(page).to have_content(generator.lenght)
    expect(page).to have_content(generator.weight)
    expect(page).to have_content(generator.kwp)
  end
end
