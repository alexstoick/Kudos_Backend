class PersonSkill < ActiveRecord::Base
  attr_accessible :person_id, :skill_id
  belongs_to :person
  belongs_to :skill

end
