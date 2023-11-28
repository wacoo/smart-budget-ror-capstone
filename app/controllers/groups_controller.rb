class GroupsController < ApplicationController
    layout 'application'
    def index
        @groups = Group.all.includes(:expenses, :group_expenses)
    end

    def show
        @group = Group.includes(:expenses, :group_expenses).find(params[:id])
    end

end
