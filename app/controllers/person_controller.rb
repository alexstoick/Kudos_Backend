class PersonController < ApplicationController
	def show

		id = params[:id]
		person = Person.select([:id,:name,:department]).find( id )
		skills = person.skills
		kudos = person.kudos.select([:id,:description])
		skill_kudos = person.skill_kudos
		sent_kudos = person.sent_kudos.select([:id,:description])

		new_skills = []

		skills.each do |skill|
			current_skill_kudos = skill_kudos.select {|f| f[:skill_id]==skill.id }
			object = {}
			object[:kudos] = current_skill_kudos.count
			object[:skill] = skill.name
			new_skills.push(object)
		end

		new_skills = new_skills.sort{ |a1,a2| a2[:kudos] <=> a1	[:kudos] }

		render json: {
			"person" 		=> person ,
			"kudos" 		=> kudos ,
			"skills" 		=> new_skills ,
			"sent_kudos" 	=> sent_kudos
		}
	end

	def index
		people = Person.select([:id,:name,:department]).all
		render json: people
	end


	def find

		skills_string = params[:skill]
		skills_string.downcase!
		required_skills = skills_string.split
		required_skills.sort

		people = Person.select([:id,:name]).all
		people_with_skill = []

		people.each do |person|
			skills = person.skills.pluck(:name)
			lowercase_skills = []

			skills.each do |skill|
				lowercase_skills.push(skill.downcase)
			end

			# render json: { "lw_s" => lowercase_skills , "req" => required_skills , "join" => lowercase_skills & required_skills}
			# return
			if (lowercase_skills & required_skills).sort == required_skills
				people_with_skill.push(person)
			end
		end
		render json: people_with_skill
	end


end
