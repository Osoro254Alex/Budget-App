class Group < ApplicationRecord
  has_one_attached :icon

  validates :name, presence: true, length: { maximum: 250 }
  validates :icon, presence: true

  belongs_to :author, class_name: 'User'
  has_many :group_expenses, class_name: 'GroupExpense', dependent: :destroy
  has_many :expenses, through: :group_expenses

  def total_amount
    expenses.sum(:amount)
  end
end
