require 'correios-cep'

class Cep
  def self.find(cep)
    return {} if cep.blank?

    cep = cep.remove('-')

    return {} if cep.size != 8

    finder = Correios::CEP::AddressFinder.new
    finder.get(cep)
  end
end
