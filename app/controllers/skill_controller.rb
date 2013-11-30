class SkillController < ApplicationController

	def index

		render json: Skill.pluck(:name)

	end

end
