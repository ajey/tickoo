class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # default sorting: latest on the top
  default_scope { order(updated_at: :desc) }
  
end