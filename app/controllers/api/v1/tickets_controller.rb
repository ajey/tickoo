class Api::V1::TicketsController < Api::V1::BaseController
  
  def index
    tickets, closed_tickets, open_tickets = current_user.get_tickets

    if params["query"]
      tickets = tickets.searched_by_keyword(params["query"])
      closed_tickets = closed_tickets.searched_by_keyword(params["query"])
      open_tickets = open_tickets.searched_by_keyword(params["query"]) if !current_user.customer?
    end

    render json: {:tickets => tickets, :closed_tickets => closed_tickets, :open_tickets => open_tickets}
  end
  
  def create
    ticket = Ticket.create(ticket_params)
    render json: current_user.tickets_raised.notclosed
  end

  def destroy
    respond_with Ticket.destroy(params[:id])
  end

  def update
    ticket = Ticket.find(params["id"])
    ticket.update_attributes(ticket_params)
    respond_with ticket, json: ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :priority, :customer_id, :agent_id, :status)
  end
  
end
