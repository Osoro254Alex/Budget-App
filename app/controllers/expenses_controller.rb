class ExpensesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @group_expenses = @group.group_expenses
    @expenses = Expense.joins(:group_expenses, :groups)
                  .where('expenses.id = group_expenses.expense_id')
                  .where('groups.id = group_expenses.group_id')
                  .where('groups.id = ?', params[:group_id]).order('expenses.created_at DESC')
  end

  def new
    @expense = Expense.new
    @groups = current_user.groups
  end

  def create
    @expense = Expense.new(name: params[:name], amount: params[:amount], author_id: params[:author_id])


    if @expense.save
      group_expense = GroupExpense.new(group_id: params[:group], expense_id: @expense.id)
      group_expense.save
      flash[:success] = 'Transaction was successfully.'
      redirect_to group_expenses_path(params[:group])
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :author_id)
  end

end
