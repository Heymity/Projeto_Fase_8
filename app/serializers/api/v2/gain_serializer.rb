class Api::V2::GainSerializer < ActiveModel::Serializer
  attributes :id, :description, :value, :date, :user_id, :created_at, :updated_at, :is_late
    
    def is_late
       Date.current > object.date if object.date.present? 
    end
    
    belongs_to :user
end
