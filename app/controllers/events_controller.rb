class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    #@events = Expense.joins('INNER JOIN items ON items.id = expenses.item_id')
    #.select('expenses.id as id,concat(items.name," ",FORMAT(money,0),"円") as title, concat(day," 00:00:00") as start, concat(day," 00:00:00") as end, colorcode as color , "false" as allday')
    #conn = ActiveRecord::Base.connection
    sql = " select min(expenses.id) as id, "  +
          " concat(categories.name,' ',TO_CHAR(sum(money),'FM9,999,999'),'円') as title, " + 
          " concat(day,' 00:00:00') as start, " +
          " concat(day,' 00:00:00') as end, " +
          " categories.colorcode as color , " + 
          " '#333333' as " + %Q{"textColor"} + " , " +
          " 'false' as allday " + 
          " from (expenses INNER JOIN items ON items.id = expenses.item_id) " + 
          " inner join categories on items.category_id = categories.id " + 
          " group by day,categories.id "
    
    @events = ActiveRecord::Base.connection.select_all(sql)

    respond_to do |format|
      format.json { render :json => @events }
    end
  end


  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start, :end, :color, :allDay)
    end
end
