class SkillKudo < ActiveRecord::Base
  attr_accessible :kudo_id, :skill_id
  belongs_to :kudo
  belongs_to :skill
end
