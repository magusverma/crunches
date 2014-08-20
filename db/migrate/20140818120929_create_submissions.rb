class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :status
      t.string :submitted_answer
      t.datetime :time_of_submission
      t.string :ip

      t.timestamps
    end
  end
end
