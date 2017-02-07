class Ticket < ApplicationRecord
  
  # belongs_to :user, :foreign_key => "customer_id"
  belongs_to :agent, class_name: "User", foreign_key: :agent_id, optional: true
  belongs_to :customer, class_name: "User", foreign_key: :customer_id
  
  has_many :conversations
  
  def self.priorities
    ["Low", "Moderate", "High", "Urgent"]
  end
  
  # Ticket statuses
  scope :unassigned, -> { where(agent_id: nil) }
  scope :closed, -> { where(status: "Closed") }
  scope :inprogress, -> { where(agent_id: !nil) }
  scope :notclosed, -> { where("status != ?", "Closed") }
  
  def closed?
    self.status == "Closed"
  end
  
  scope :searched_by_keyword, lambda {|query|
    self.where("title like ? or description like ? or priority = ?", 
      "%#{query}%", "%#{query}%", query)
  }
  
end