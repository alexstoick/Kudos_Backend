class KudoController < ApplicationController
	def create

		id = params[:id]
		person = Person.find(id)
		skills_string = params[:skills]

		#explode skills by space
		#create or find them
		#associate them with the person if required

		skills = skills_string.split

		skills.each do |s|
			skill = Skill.where( "name like ?" , "%#{s}").first

			if ( skill.nil? )
				skill = Skill.new
				skill.name = s
				skill.save!
			end

			person_skill = PersonSkill.find_by_person_id_and_skill_id(id,skill.id)
			if ( person_skill.nil? )
				person_skill = PersonSkill.new
				person_skill.person_id = id
				person_skill.skill_id = skill.id
				person_skill.save!
			end

		end



		render json: person.skills.pluck(:name)
	end
end
