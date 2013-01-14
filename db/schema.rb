# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121107100744) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "administrators", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "administrators", ["email"], :name => "index_administrators_on_email", :unique => true
  add_index "administrators", ["reset_password_token"], :name => "index_administrators_on_reset_password_token", :unique => true

  create_table "appconfigs", :force => true do |t|
    t.boolean  "enable_recaptcha"
    t.string   "default_password"
    t.date     "registration_start"
    t.date     "registration_end"
    t.boolean  "registration_override"
    t.boolean  "registration_on"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "challenges", :force => true do |t|
    t.integer  "student_id"
    t.integer  "total_questions"
    t.integer  "last_attempted_question"
    t.integer  "last_question"
    t.integer  "total_score"
    t.boolean  "completed"
    t.datetime "time_limit"
    t.datetime "time_taken"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "challenges", ["completed"], :name => "index_challenges_on_completed"
  add_index "challenges", ["last_attempted_question"], :name => "index_challenges_on_last_attempted_question"
  add_index "challenges", ["last_question"], :name => "index_challenges_on_last_question"
  add_index "challenges", ["time_limit"], :name => "index_challenges_on_time_limit"
  add_index "challenges", ["time_taken"], :name => "index_challenges_on_time_taken"
  add_index "challenges", ["total_questions"], :name => "index_challenges_on_total_questions"
  add_index "challenges", ["total_score"], :name => "index_challenges_on_total_score"

  create_table "questionens", :force => true do |t|
    t.integer  "question_type"
    t.string   "topic"
    t.integer  "difficulty"
    t.text     "question_text"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "choice4"
    t.string   "answer"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "questionens", ["answer"], :name => "index_questionens_on_answer"
  add_index "questionens", ["choice1"], :name => "index_questionens_on_choice1"
  add_index "questionens", ["choice2"], :name => "index_questionens_on_choice2"
  add_index "questionens", ["choice3"], :name => "index_questionens_on_choice3"
  add_index "questionens", ["choice4"], :name => "index_questionens_on_choice4"
  add_index "questionens", ["topic"], :name => "index_questionens_on_topic"

  create_table "questions", :force => true do |t|
    t.integer  "question_idx"
    t.integer  "student_id"
    t.integer  "question_no"
    t.string   "answer"
    t.integer  "score"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "questions", ["answer"], :name => "index_questions_on_answer"
  add_index "questions", ["question_idx"], :name => "index_questions_on_question_idx"
  add_index "questions", ["question_no"], :name => "index_questions_on_question_no"
  add_index "questions", ["score"], :name => "index_questions_on_score"
  add_index "questions", ["student_id"], :name => "index_questions_on_student_id", :unique => true

  create_table "questionzhcns", :force => true do |t|
    t.integer  "question_type"
    t.string   "topic"
    t.integer  "difficulty"
    t.text     "question_text"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "choice4"
    t.string   "answer"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "questionzhcns", ["answer"], :name => "index_questionzhcns_on_answer"
  add_index "questionzhcns", ["choice1"], :name => "index_questionzhcns_on_choice1"
  add_index "questionzhcns", ["choice2"], :name => "index_questionzhcns_on_choice2"
  add_index "questionzhcns", ["choice3"], :name => "index_questionzhcns_on_choice3"
  add_index "questionzhcns", ["choice4"], :name => "index_questionzhcns_on_choice4"
  add_index "questionzhcns", ["topic"], :name => "index_questionzhcns_on_topic"

  create_table "questionzhtws", :force => true do |t|
    t.integer  "question_type"
    t.string   "topic"
    t.integer  "difficulty"
    t.text     "question_text"
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "choice4"
    t.string   "answer"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "questionzhtws", ["answer"], :name => "index_questionzhtws_on_answer"
  add_index "questionzhtws", ["choice1"], :name => "index_questionzhtws_on_choice1"
  add_index "questionzhtws", ["choice2"], :name => "index_questionzhtws_on_choice2"
  add_index "questionzhtws", ["choice3"], :name => "index_questionzhtws_on_choice3"
  add_index "questionzhtws", ["choice4"], :name => "index_questionzhtws_on_choice4"
  add_index "questionzhtws", ["topic"], :name => "index_questionzhtws_on_topic"

  create_table "rhconfigs", :force => true do |t|
    t.string   "country"
    t.integer  "total_qn"
    t.integer  "qn_per_topic"
    t.integer  "add_diff_qn"
    t.integer  "add_norm_qn"
    t.integer  "add_easy_qn"
    t.integer  "time_limit"
    t.datetime "challenge_start"
    t.datetime "challenge_end"
    t.boolean  "challenge_on"
    t.boolean  "challenge_override"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "rhconfigs", ["add_diff_qn"], :name => "index_rhconfigs_on_add_diff_qn"
  add_index "rhconfigs", ["add_easy_qn"], :name => "index_rhconfigs_on_add_easy_qn"
  add_index "rhconfigs", ["add_norm_qn"], :name => "index_rhconfigs_on_add_norm_qn"
  add_index "rhconfigs", ["challenge_end"], :name => "index_rhconfigs_on_challenge_end"
  add_index "rhconfigs", ["challenge_on"], :name => "index_rhconfigs_on_challenge_on"
  add_index "rhconfigs", ["challenge_override"], :name => "index_rhconfigs_on_challenge_override"
  add_index "rhconfigs", ["challenge_start"], :name => "index_rhconfigs_on_challenge_start"
  add_index "rhconfigs", ["country"], :name => "index_rhconfigs_on_country", :unique => true
  add_index "rhconfigs", ["qn_per_topic"], :name => "index_rhconfigs_on_qn_per_topic"
  add_index "rhconfigs", ["time_limit"], :name => "index_rhconfigs_on_time_limit"

  create_table "students", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "contact_number",         :default => "", :null => false
    t.string   "school",                 :default => "", :null => false
    t.string   "country",                :default => "", :null => false
    t.string   "language",               :default => "", :null => false
    t.string   "lecturer_name",          :default => "", :null => false
    t.string   "lecturer_email",         :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "trial"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "students", ["confirmation_token"], :name => "index_students_on_confirmation_token", :unique => true
  add_index "students", ["country"], :name => "index_students_on_country"
  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["encrypted_password"], :name => "index_students_on_encrypted_password"
  add_index "students", ["first_name"], :name => "index_students_on_first_name"
  add_index "students", ["language"], :name => "index_students_on_language"
  add_index "students", ["last_name"], :name => "index_students_on_last_name"
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true
  add_index "students", ["trial"], :name => "index_students_on_trial"

end
