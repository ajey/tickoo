class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :tickets_raised, class_name: "Ticket", foreign_key: :customer_id
  has_many :tickets_assigned, class_name: "Ticket", foreign_key: :agent_id
  
  has_many :conversations
  
  def agent?
    self.role == "agent"
  end
  
  def customer?
    self.role == "customer"
  end
  
  def admin?
    self.role == "admin"
  end
  
  scope :non_admin_users, -> { where("role != ?", "admin") }
  
  def get_tickets
    if self.agent? or self.admin?
      tickets = self.admin? ? Ticket.all : self.tickets_assigned.notclosed
      closed_tickets  = self.tickets_assigned.closed
      open_tickets = Ticket.unassigned
    elsif self.customer?
      tickets = self.tickets_raised.notclosed
      closed_tickets  = self.tickets_raised.closed
    end
    return tickets, closed_tickets, open_tickets
  end
  
end