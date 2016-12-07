class Material < ApplicationRecord
  has_many :logs
  validates :nome, presence: { message: "Campo Nome é obrigaório !" },
                   uniqueness: { message: "Já existe outro material com este nome !" }
  validates :qnt, presence: { message: "Campo quantidade é obrigaório !" }
  validate :PositiveNumberValidates, if: 'qnt.present?'
  private
    def Nome_Case_Sensitive_Validate
      errors.add("nome", "Nome deve ter primeira letra maiúscula") unless nome =~ /[A-Z].*/
    end
    def PositiveNumberValidates
      errors.add("Qnt", "Quantidade tem que ser positiva") unless qnt>=0
    end
end
