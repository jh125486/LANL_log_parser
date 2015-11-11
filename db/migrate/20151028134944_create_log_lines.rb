class CreateLogLines < ActiveRecord::Migration
  def change
    create_table :log_lines do |t|
      t.text :message
      t.integer :number, index: true
      t.references :log, index: true, foreign_key: true
      t.references :node, index: true, foreign_key: true
      t.string :process
      t.string :pid
      t.datetime :timestamp
      t.integer :priority
      t.text :comment
      t.string :error_type
    end
  end
end
