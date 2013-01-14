class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :student_id
      t.integer :total_questions
      t.integer :last_attempted_question
      t.integer :last_question
      t.integer :total_score
      t.boolean :completed
      t.datetime :time_limit
      t.datetime :time_taken

      t.timestamps
    end
    add_index :challenges, :total_questions, :unique => false
    add_index :challenges, :last_attempted_question, :unique => false
    add_index :challenges, :last_question, :unique => false
    add_index :challenges, :total_score, :unique => false
    add_index :challenges, :completed, :unique => false
    add_index :challenges, :time_limit, :unique => false
    add_index :challenges, :time_taken, :unique => false
  end
end
