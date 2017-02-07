class DownloadHistory < Prawn::Document
  
  def initialize(agent)
    super(top_margin: 70)
    @agent = agent
    agent_heading
    tickets
  end
  
  def agent_heading
    text "Tickets closed in last 30 days by agent #{@agent.name}", size: 14, style: :bold
  end
  
  def tickets
    move_down 20
    table ticket_rows do
      row(0).font_style = :bold
      # columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def ticket_rows
    [["ID", "Title", "Description", "Priority", "Created on", "Closed on"]] +
    @agent.tickets_assigned.closed.where('updated_at > ?', 30.days.ago).map do |t|
      [t.id, t.title, t.description, t.priority, t.created_at.to_formatted_s(:short), t.updated_at.to_formatted_s(:short)]
    end
  end
  
end