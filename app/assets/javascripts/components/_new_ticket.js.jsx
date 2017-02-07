var NewTicket= React.createClass({ 
	handleClick() { 
		var title = this.refs.title.value; 
		var description = this.refs.description.value;
		var priority = this.refs.priority.value;
		var current_user_id = this.props.current_user_id;
		{   
			title != "" && description != ""
			? $.ajax({ 
				url: '/api/v1/tickets', 
				type: 'POST', 
				data: { ticket: { title: title, description: description, agent_id: null, customer_id: current_user_id, status: 'Open', priority: priority } }, 
				success: (tickets) => {
					this.refs.title.value = "";
					this.refs.description.value = "";
					this.refs.priority.value = "low";
					this.props.handleSubmit(tickets); 
					$("#ticket_form").click();
				}
		        })
			:null	
	    }
    },
    handleChange(event) {
      this.setState({value: event.target.value});
    },
	
	render() { 
		return ( 
			<div id='collapseExample' className='collapse'>
			  <p className='well'>
				<input ref='title' id='ticket_title' placeholder='Title' className="form-control" /><br/><br/>
				<textarea ref='description' id='ticket_description' placeholder='Description' className="form-control" /><br/><br/>
	            <select ref='priority' onChange={this.handleChange} id='priority' className="form-control">
	              <option value="low"> Low </option>
	              <option value="medium"> Medium </option>
	              <option value="high"> High </option>
	            </select><br/><br/>
				<button onClick={this.handleClick} className="btn btn-default">Submit</button>
			  </p>
			</div>
	) }
});