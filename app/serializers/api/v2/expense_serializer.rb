class Api::V2::ExpenseSerializer < ActiveModel::Serializer
    attributes :id, :description, :value, :date, :user_id, :created_at, :updated_at
    
    def is_late
       Date.current > object.date if object.date.present? 
    end
    
    belongs_to :user
end
