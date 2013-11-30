class Kudo < ActiveRecord::Base
  attr_accessible :description, :person_id, :sender_id
  belongs_to :person
  belongs_to :skill
  belongs_to :sender , :class_name => "Person"
  has_many :skill_kudos
end
