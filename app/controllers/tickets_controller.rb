class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :close, :assign]
  before_action :authenticate_user!

  # GET /tickets
  # GET /tickets.json
  def index
    # @open_tickets are tickets not assgined to any agent
    # @ip_tickets are in progress tickets
    # @closed_tickets are closed tickets to show in history
    @ip_tickets, @closed_tickets, @open_tickets = current_user.get_tickets
  end
  

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @conversations = @ticket.conversations
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # method to create new conversation for a ticket
  def add_conversation
    @conv = Conversation.new(conversation_params)
    @conv.ticket_id = params[:id]
    @conv.save!
    @conversations = @conv.ticket.conversations
  end
  
  # method to close ticket
  def close
    @ticket.update_attributes(status: "Closed")
    redirect_to tickets_path
  end
  
  def assign
    respond_to do |format|
      if @ticket.update_attributes({:status => "In-progress", :agent_id => current_user.id})
        # format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render json: {:tickets => current_user.tickets_assigned.notclosed, 
          :closed_tickets => current_user.tickets_assigned.closed, :open_tickets => Ticket.unassigned} }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # method to download ticket history for agent
  def download_history
    agent = User.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = DownloadHistory.new(agent)
        send_data pdf.render, filename: "#{agent.name}_history",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :priority, :customer_id, :agent_id, :status)
    end
    
    def conversation_params
      params.require(:conversation).permit(:message, :ticket_id, :user_id)
    end
end
