class ExpensesController < ApplicationController
    before_action :authenticate_user!
    layout 'application'
    def index
        @expenses = Expense.all.includes(:groups)
    end

    def new
        @groups = Group.all
        @expense = Expense.new
    end

    def create
        @expense = Expense.new(expense_params)
        @expense.author = current_user
      
        if @expense.save
          @expense.groups << Group.find(params[:expense][:group]) if params[:expense][:group].present?
          redirect_to expenses_path, notice: "Expense created successfully."
        else
          flash.now[:error] = "Failed to create expense."
          @groups = Group.all # Assign @groups variable here
          render :new, status: :unprocessable_entity
        end
      end
      
      private
      
      def expense_params
        params.require(:expense).permit(:name, :amount, group_ids: [])
      end
end
