class Expense < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  belongs_to :author, class_name: 'User'

  has_many :group_expenses, class_name: 'GroupExpense', dependent: :destroy
  has_many :groups, through: :group_expenses, dependent: :destroy
end
