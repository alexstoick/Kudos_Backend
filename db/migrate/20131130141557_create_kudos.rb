class CreateKudos < ActiveRecord::Migration
  def change
    create_table :kudos do |t|
      t.integer :person_id
      t.string :description
      t.integer :sender_id

      t.timestamps
    end
  end
end
