class CreateQuestionens < ActiveRecord::Migration
  def change
    create_table :questionens do |t|
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
    add_index :questionens, :topic, :unique => false
    add_index :questionens, :choice1, :unique => false
    add_index :questionens, :choice2, :unique => false
    add_index :questionens, :choice3, :unique => false
    add_index :questionens, :choice4, :unique => false
    add_index :questionens, :answer, :unique => false
  end
end
