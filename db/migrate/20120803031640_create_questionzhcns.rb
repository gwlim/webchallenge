class CreateQuestionzhcns < ActiveRecord::Migration
  def change
    create_table :questionzhcns do |t|
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
    add_index :questionzhcns, :topic, :unique => false
    add_index :questionzhcns, :choice1, :unique => false
    add_index :questionzhcns, :choice2, :unique => false
    add_index :questionzhcns, :choice3, :unique => false
    add_index :questionzhcns, :choice4, :unique => false
    add_index :questionzhcns, :answer, :unique => false
  end
end
