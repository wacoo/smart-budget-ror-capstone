class GroupsController < ApplicationController
    before_action :authenticate_user!
    layout 'application'
    def index
        if params[:order] == 'recent'
            @groups = Group.includes(:expenses, :group_expenses).order(created_at: :desc)
        elsif params[:order] == 'ancient'
            @groups = Group.includes(:expenses, :group_expenses).order(created_at: :asc)
        else
            @groups = Group.includes(:expenses, :group_expenses).order(created_at: :desc)
        end

        @group_expenses = 0
        @groups.each do |group|
            @group_expenses += group.expenses.sum(:amount)
        end
    end

    def show
        @group = Group.includes(:expenses, :group_expenses).find(params[:id])
        @expenses_asc = @group.expenses.order(created_at: :asc)
        @total_expense = @group.expenses.sum(:amount)
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        @group.user = current_user
        if @group.save
          redirect_to groups_path, notice: "Group created successfully."
        else
            # puts @group.errors.full_messages
            flash.now[:error] = "Error creating the group."
            render :new, status: :unprocessable_entity
        end
      end
    
      private
    
      def group_params
        params.require(:group).permit(:name, :icon)
      end

end
