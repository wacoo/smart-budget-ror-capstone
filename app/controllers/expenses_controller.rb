class ExpensesController < ApplicationController
    layout 'application'
    def index
        @expenses = Expense.all.includes(:groups)
    end
end
