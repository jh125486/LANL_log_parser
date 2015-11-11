class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :file
      t.string :type

      t.timestamps null: false
    end
  end
end
