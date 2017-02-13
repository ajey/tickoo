var Tickets = React.createClass({
	
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
			  	<td><a data-toggle="modal" data-target="#ticket" data-remote="true" href={url}>{ticket.title}</a></td>
			  	<td>{ticket.description.trimToLength(50)}</td>
			  	<td>{ticket.priority}</td>
			  	<td>{ticket.status}</td>
				<td>{strftime('%d %b %H:%M', new Date(ticket.created_at))}</td>
		    </tr>
			) });
		return( 
			<div>
				{
					this.props.tickets.length > 0
					? <h4>Tickets in progress</h4>
					: <h4>You have no tickets in progress</h4>
				}
				{
          this.props.tickets.length > 0
          ? <table className="table table-hover">
		        <thead>
		          <tr>
		            <th className="">Title</th>
		            <th className="">Description</th>
		            <th className="">Priority</th>
		            <th className="">Status</th>
					<th className="">Added on</th>
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