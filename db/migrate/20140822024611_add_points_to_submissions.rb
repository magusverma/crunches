class AddPointsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :points, :float
    add_column :submissions, :source, :text
  end
end
