require 'correios-cep'

class FindCep
  def self.find(cep)
    cep = cep.remove('-')

    finder = Correios::CEP::AddressFinder.new
    finder.get(cep)
  end
end
