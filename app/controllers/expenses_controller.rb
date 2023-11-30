class ExpensesController < ApplicationController
    before_action :authenticate_user!
    layout 'application'
    # def index
    #     @expenses = Expense.all.includes(:groups)
    # end

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
          GroupExpense.create(expense: @expense, group: group)
        end
    
        redirect_to expenses_path, notice: "Expense created successfully."
      else
        flash.now[:error] = "Failed to create expense."
        @groups = Group.all
        render :new, status: :unprocessable_entity
      end
    end
    
    private
    
    def expense_params
      params.require(:expense).permit(:name, :amount, group_ids: [])
    end
end
