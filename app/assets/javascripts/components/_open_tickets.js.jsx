var OpenTickets = React.createClass({
	
	handleAssign(ticket) {
	        this.props.handleAssign(ticket);
	 },
	
	onUpdate(ticket) {
	        this.props.onUpdate(ticket);
	},
	
	render() {
		// alert(this.props.comp);
		var opentickets= this.props.opentickets.map((ticket) => { 
			var url = this.props.url+ticket.id
			return ( 
	    	<tr key={ticket.id}>
			  	<td><a data-toggle="modal" data-target="#ticket" data-remote="true" href={url}>{ticket.title}</a></td>
			  	<td>{ticket.description.trimToLength(50)}</td>
			  	<td>{ticket.priority}</td>
			  	<td>{ticket.status}</td>
	        <td>  {
	            this.props.show_assign && ticket.status == 'Open'
	            ? <button className="btn btn-primary btn-sm" onClick={this.handleAssign.bind(this, ticket)} id='assign_button'>Assign to yourself</button>
	            : null
	          }
					</td>
		    </tr>
			) });
		return( 
			<div>
				{
					this.props.opentickets.length > 0
					? <h4>Open tickets</h4>
					: <h4>There are no open tickets at the moment</h4>
				}
				{
		          this.props.opentickets.length > 0
          ? <table className="table table-hover">
				        <thead>
				          <tr>
				            <th className="">Title</th>
				            <th className="">Description</th>
				            <th className="">Priority</th>
				            <th className="">Status</th>
										<th className=""></th>
				          </tr>
				        </thead>
								<tbody>
									{opentickets}
								</tbody>
					</table>
          : null
        }
			<hr/>	
			</div>
		)
	} 
});