class CreateSkillKudos < ActiveRecord::Migration
  def change
    create_table :skill_kudos do |t|
      t.integer :skill_id
      t.integer :kudo_id

      t.timestamps
    end
  end
end
