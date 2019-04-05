class Gain < ApplicationRecord
    
    belongs_to :user
    
    validates_presence_of :description, :user_id
    
end
