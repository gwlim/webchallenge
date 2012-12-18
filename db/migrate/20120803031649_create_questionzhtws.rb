class CreateQuestionzhtws < ActiveRecord::Migration
  def change
    create_table :questionzhtws do |t|
      t.integer :question_type
      t.string :topic
      t.integer :difficulty
      t.text :question_text
      t.string :choice1
      t.string :choice2
      t.string :choice3
      t.string :choice4
      t.string :answer

      t.timestamps
    end
    add_index :questionzhtws, :topic, :unique => false
    add_index :questionzhtws, :choice1, :unique => false
    add_index :questionzhtws, :choice2, :unique => false
    add_index :questionzhtws, :choice3, :unique => false
    add_index :questionzhtws, :choice4, :unique => false
    add_index :questionzhtws, :answer, :unique => false
  end
end
