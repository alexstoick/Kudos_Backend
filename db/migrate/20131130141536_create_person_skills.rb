class CreatePersonSkills < ActiveRecord::Migration
  def change
    create_table :person_skills do |t|
      t.integer :person_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
