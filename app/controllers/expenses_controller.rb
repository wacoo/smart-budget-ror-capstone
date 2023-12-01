class ExpensesController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def new
    @groups = Group.all
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author = current_user

    if @expense.save
      group_id = params[:expense][:group_ids]
      if group_id.present?
        group = Group.find(group_id)
        GroupExpense.create(expense: @expense, group:)
      end

      redirect_to group_path(group), notice: 'Expense created successfully.'
    else
      flash.now[:error] = 'Failed to create expense.'
      @groups = Group.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end
end
