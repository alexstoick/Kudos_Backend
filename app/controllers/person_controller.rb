class PersonController < ApplicationController
	def show

		id = params[:id]
		person = Person.select([:id,:name,:department]).find( id )
		skills = person.skills
		kudos = person.kudos.select([:id,:description,:sender_id])
		skill_kudos = person.skill_kudos
		sent_kudos = person.sent_kudos.select([:id,:description])

		new_skills = []
		new_kudos = []
		department_kudos = {}

		kudos.each do |kudo|
			object = {}
			sender = kudo.sender
			object [:sender] = sender[:name]
			object [:description] = kudo[:description]
			department = sender[:department]
			if ( department_kudos[department].nil? )
				department_kudos[department] = 1
			else
				department_kudos[department] = department_kudos[department] + 1
			end
			new_kudos.push(object)
		end

		skills.each do |skill|
			current_skill_kudos = skill_kudos.select {|f| f[:skill_id]==skill.id }
			object = {}
			object[:kudos] = current_skill_kudos.count
			object[:skill] = skill.name
			new_skills.push(object)
		end

		new_skills = new_skills.sort{ |a1,a2| [a2[:kudos], a1[:skill]] <=> [a1[:kudos], a2[:skill]] }

		render json: {
			"person"	 		=> person ,
			"kudos" 			=> new_kudos[-5..-1] ,
			"skills" 			=> new_skills ,
			"sent_kudos"	 	=> sent_kudos ,
			"department_kudos"	=> department_kudos
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
		required_skills = required_skills.sort

		people = Person.select([:id,:name]).all
		people_with_skill = []

		people.each do |person|
			skills = person.skills.pluck(:name)
			lowercase_skills = []

			skills.each do |skill|
				lowercase_skills.push(skill.downcase)
			end

			if (lowercase_skills & required_skills).sort == required_skills
				sum = 0
				skill_kudos = person.skill_kudos
				(required_skills).each do |skill|
					current_skill_kudos = skill_kudos.select {|f| f[:skill_id]==Skill.find_by_name(skill).id }
					sum = sum + current_skill_kudos.count
				end
				object = {}
				object [:name] = person[:name]
				object [:kudos] = sum
				people_with_skill.push(object)
			end
		end
		people_with_skill = people_with_skill.sort{ |a1,a2| a2[:kudos] <=> a1[:kudos]}
		render json: people_with_skill
	end

	def leaderboard
		people = Person.all
		sorted_people = []
		people.each do |person|
			object= {}
			object[:id] = person.id
			object[:name] = person.name
			object[:kudos] = person.kudos.count
			sorted_people.push(object)
		end

		sorted_people = sorted_people.sort{ |a1,a2| a2[:kudos] <=> a1[:kudos] }

		render json:sorted_people

	end


end
