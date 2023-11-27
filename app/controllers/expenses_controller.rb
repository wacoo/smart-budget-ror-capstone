class ExpensesController < ApplicationController

    def index
        @expenses = Expense.all.includes(:groups)
    end
end
