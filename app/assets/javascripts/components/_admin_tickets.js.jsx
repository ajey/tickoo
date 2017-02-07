var AdminTickets = React.createClass({
	
	handleDelete(id) {
	        this.props.handleDelete(id);
	    },	

	onUpdate(ticket) {
	        this.props.onUpdate(ticket);
	},
	
	render() {
		tickets= this.props.tickets.map((ticket) => { 
			var url = this.props.url+ticket.id
			return ( 
	      <tr key={ticket.id}>
					<td>{ticket.id}</td>
			  	<td><a data-toggle="modal" data-target="#ticket" data-remote="true" href={url}>{ticket.title}</a></td>
			  	<td>{ticket.description.trimToLength(50)}</td>
			  	<td>{ticket.priority}</td>
					<td>{ticket.customer_id}</td>
					<td>{ticket.agent_id}</td>
			  	<td>{ticket.status}</td>
					<td>{strftime('%d %b %H:%M', new Date(ticket.created_at))}</td>
					<td>{strftime('%d %b %H:%M', new Date(ticket.updated_at))}</td>
		    </tr>
			) });
		return( 
			<div>
				{
          this.props.tickets.length > 0
          ? <table className="table table-hover">
		        <thead>
		          <tr>
		            <th className="">ID</th>
								<th className="">Title</th>
		            <th className="">Description</th>
		            <th className="">Priority</th>
								<th className="">Customer ID</th>
								<th className="">Agent ID</th>
								<th className="">Status</th>
								<th className="">Created on</th>
								<th className="">Closed on</th>
		          </tr>
		        </thead>
						<tbody>
							{tickets}
						</tbody>
			</table>
          : null
        }
			</div> 
		)
	} 
});