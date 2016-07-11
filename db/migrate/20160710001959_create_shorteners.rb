class CreateShorteners < ActiveRecord::Migration
  def change
    create_table :shorteners do |t|

      t.timestamps null: false
    end
  end
end
