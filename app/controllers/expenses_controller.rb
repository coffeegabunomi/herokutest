class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  after_action :index, only: [:create, :update, :destroy]
  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all.order('day DESC').page(params[:page]).per(12)
  end

  def show

  end

  def sum

        sql = " select min(expenses.id) as id, "  +
          " concat(categories.name,' ',TO_CHAR(sum(money),'FM9,999,999'),'円') as title, " + 
          " concat(day,' 00:00:00') as start, " +
          " concat(day,' 00:00:00') as end, " +
          " categories.colorcode as color , " + 
          " 'black' as textColor , " +
          " 'false' as allday " + 
          " from (expenses INNER JOIN items ON items.id = expenses.item_id) " + 
          " inner join categories on items.category_id = categories.id " + 
          " group by day,categories.id "
    
    @events = ActiveRecord::Base.connection.select_all(sql)
    Expense.group(:month).pluck(:month)

#    @chartdata_ary = []
#    Category.find_each do |cate|
#      @scores = {"name" =>"" ,"data" =>""}
#      @item_in = Item.where(category_id:cate.id).pluck(:id)
#      @scores["name"] = cate.name
#      @scores["data"] = Expense.where("item_id IN (?)",@item_in).group("to_char(day ,'YYYY年MM月')").sum(:money)
#
#      @chartdata_ary.push(@scores)
#      @color_ary = Category.pluck(:colorcode)
#    end
  end

  def comparison
    month = params[:month]
    data_month = month.to_s.slice(0..3) + "-" + month.to_s.slice(4..5) + "-15"

    @labels_month = month.to_s.slice(0..3) + "年" + month.to_s.slice(4..5) + "月"

    temp_year = month.to_s.slice(0..3)
    temp_month = month.to_s.slice(4..5)

    if temp_month == '01' then
      @before_month = data_month
      @after_month =  temp_year + "-" + "02" + "-14"
    elsif temp_month == '12' then
      @before_month = data_month
      @after_month =  (temp_year.to_i + 1).to_s  + "-" + "01" + "-14"
    else
      @before_month = data_month
      @after_month =  temp_year + "-" + format("%02d", (temp_month.to_i + 1).to_s)  + "-14"
    end

    @color_data = Category.order(:id).pluck(:colorred,:colorgreen,:colorblue,:name)
    @expense_labels_color = []
    @budget_labels_color = []

    @labels_data = []

    @color_data.each{|rows|
      @expense_labels_color.push('rgba(' + rows[0].to_s + ','  + rows[1].to_s + ',' + rows[2].to_s + ',1.0)')
      @budget_labels_color.push('rgba(' + rows[0].to_s + ','  + rows[1].to_s + ',' + rows[2].to_s + ',0.1)')
      @labels_data.push(rows[3])
    }

    @budget_data = Budget.where(month:data_month).pluck(:money)

    @expense_ary = []
    @budget_ary = []
    @percent_ary = []

    Category.find_each do |cate|
      @item_in = Item.where(category_id:cate.id).pluck(:id)
      expense_scores = Expense.where("item_id IN (?) and day >= ? and day <= ?",@item_in,@before_month,@after_month).sum(:money)
      budget_scores = Budget.where("category_id IN (?) and month = ?",cate.id,data_month).sum(:money)

      if budget_scores == 0 then
        percent_data = 0
      else
        percent_data = (expense_scores.to_f / budget_scores.to_f) * 100
      end
      @expense_ary.push(expense_scores)
      @budget_ary.push(budget_scores)
      @percent_ary.push(percent_data.round)
    end

    #予実表の月リンク
    @budget_month_ary = Budget.order(:month).group(:month).pluck(:month)


    @thismonth = data_month
  end


  # GET /expenses/new
  def new
    defaultday = params[:day]
    @expense = Expense.new
    @expense.day = defaultday
    @categories = Category.all

    @expenses = Expense.where("day = ?",@expense.day).ordered

  end

  # GET /expenses/1/edit
  def edit
    @categories = Category.all 
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.save
    # redirect_to expenses_path
    redirect_to  action: 'new', day: @expense.day


  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    @expense.update(expense_params)
    #redirect_to expenses_path
    redirect_to  action: 'new', day: @expense.day
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    #redirect_to expenses_path
    redirect_to  action: 'new', day: @expense.day
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:day, :money, :item_id)
    end
end
