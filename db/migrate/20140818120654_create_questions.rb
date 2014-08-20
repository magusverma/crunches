class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :theme_id
      t.string :title
      t.integer :points
      t.text :problem_statement
      t.string :answer
      t.text :explanation

      t.timestamps
    end
  end
end
