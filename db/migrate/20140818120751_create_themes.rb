class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.text :details
      t.string :database_url

      t.timestamps
    end
  end
end
