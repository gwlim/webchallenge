class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :question_idx
      t.integer :student_id
      t.integer :question_no
      t.string :answer
      t.integer :score
      
      t.timestamps
    end
    add_index :questions, :question_idx, :unique => false
    add_index :questions, :student_id, :unique => true
    add_index :questions, :question_no,   :unique => false
    add_index :questions, :answer, :unique => false
    add_index :questions, :score, :unique => false
  end
end
