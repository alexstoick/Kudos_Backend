class Skill < ActiveRecord::Base
  attr_accessible :name


  def lowercase_name
  	return name.to_downcase
  end
end
