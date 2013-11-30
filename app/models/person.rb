class Person < ActiveRecord::Base
  attr_accessible :department, :name

  has_many :person_skills
  has_many :skills, :through => :person_skills

  has_many :kudos
  has_many :skill_kudos, :through => :kudos

  has_many :sent_kudos, :class_name => "Kudo", :foreign_key => :sender_id

end
