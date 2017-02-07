var ClosedTickets = React.createClass({
	
	onUpdate(ticket) {
	        this.props.onUpdate(ticket);
	},
	
	render() {
		// alert(this.props.comp);
		var closedtickets= this.props.closedtickets.map((ticket) => { 
			var url = this.props.url+ticket.id
			return ( 
		    <tr key={ticket.id}>
				  <td><a data-toggle='modal' data-target='#ticket' data-remote='true' href={url}>{ticket.title}</a></td>
				  <td>{ticket.description.trimToLength(50)}</td>
				  <td>{ticket.priority}</td>
				  <td>{ticket.status}</td>
					<td>{strftime('%d %b %H:%M', new Date(ticket.created_at))}</td>
					<td>{strftime('%d %b %H:%M', new Date(ticket.updated_at))}</td>
			  </tr>
			) });
		var download_url = this.props.download_url+this.props.current_user_id+'.pdf'
		return(
			<div>
					{
						this.props.closedtickets.length > 0
						? <h4>History</h4>
						: <h4>Nothing to show in the history</h4>
					}
					{
					this.props.user_role == "agent"
					? <a target="_blank" href={download_url} className="pull-right btn btn-warning btn-sm">Download history (tickets closed in last 30 days)</a>
					: null
				  }
				{
					this.props.closedtickets.length > 0
          ? <table className="table table-hover">
				        <thead>
				          <tr>
				            <th className="">Title</th>
				            <th className="">Description</th>
				            <th className="">Priority</th>
				            <th className="">Status</th>
										<th className="">Created on</th>
										<th className="">Closed on</th>
				          </tr>
				        </thead>
								<tbody>
									{closedtickets}
								</tbody>
					</table>
          : null
        }
			</div>
		)
	} 
});