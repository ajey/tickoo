var Index = React.createClass({
	getInitialState() { 
		return { 
			tickets: [] ,
			closedtickets: [],
			opentickets: []
		} 
	},
	
	handleSearch: function(data) {
		this.setState({tickets: data.tickets, closedtickets: data.closed_tickets, opentickets: data.open_tickets})
	},
	
	componentDidMount() { 
		// this happens first time page is loaded
		this.setState({tickets: this.props.data })
		this.setState({closedtickets: this.props.closedtickets })
		this.setState({opentickets: this.props.opentickets })
	},
	
    handleSubmit(tickets) {
        var newState = tickets;
        this.setState({ tickets: newState })
    },
	
    handleDelete(id) {
        $.ajax({
            url: `/api/v1/tickets/${id}`,
            type: 'DELETE',
            success:() => {
               this.removeTicketClient(id);
            }
        });
    },   
	 
    handleAssign(ticket) {
		
        $.ajax({
            url: `/tickets/${ticket.id}/assign`,
            type: 'PUT',
            data: { id: ticket.id },
            success: (response) => {
              this.setState({tickets: response.tickets, closedtickets: response.closed_tickets, opentickets: response.open_tickets})
            }
        });
    },
	
	
    removeTicketClient(id) {
        var newTickets = this.state.tickets.filter((ticket) => {
            return ticket.id != id;
        });

        this.setState({ tickets: newTickets });
    },
	
	handleUpdate(ticket) {
        $.ajax({
                url: `/api/v1/tickets/${ticket.id}`,
                type: 'PUT',
                data: { ticket: ticket },
                success: () => {
                    this.updateTickets(ticket);
                }
            }
    )},
		
    updateTickets(ticket) {
        var tickets = this.state.tickets.filter((i) => { return i.id != ticket.id });
        tickets.push(ticket);

        this.setState({tickets: tickets });
    },
	
    render() {
        return (
            <div>
			  
	          {
	            this.props.user_role == "customer"
	            ? <NewTicket handleSubmit={this.handleSubmit} current_user_id={this.props.current_user_id}/>
	            : null
	          }
				<br/>
   		  <div className="row">
			    <div className="col-md-4">
				    <SearchForm handleSearch={this.handleSearch} />
				  </div>
				</div>
			  <br/>
	          {
	            this.props.user_role == "admin"
	            ? <AdminTickets comp='nonclosedtickets' tickets={this.state.tickets} 
			      onUpdate={this.handleUpdate} url='/tickets/' user_role={this.props.user_role}/>
	            : <Tickets comp='nonclosedtickets' tickets={this.state.tickets} 
			      onUpdate={this.handleUpdate} url='/tickets/' user_role={this.props.user_role}/>
	          }
			  
			  <hr/>
	          {
	            this.props.user_role == "agent"
	            ? <OpenTickets comp='opentickets' opentickets={this.state.opentickets}
				onUpdate={this.handleUpdate} show_assign={this.props.show_assign} handleAssign={this.handleAssign} url='/tickets/'/>
	            : null
	          }
				
	          {
	            this.props.user_role != "admin"
	            ? <ClosedTickets comp='closedtickets' closedtickets={this.state.closedtickets}
				onUpdate={this.handleUpdate} url='/tickets/' download_url='/download_history/' user_role={this.props.user_role} current_user_id={this.props.current_user_id}/>
	            : null
	          }			
			
            </div>
        )
    }
});