class <%= class_name %> < ActiveRecord::Migration
  def self.up
    create_table "<%= tech_debts_table_name %>", :force => true do |t|
      t.string :title
      t.integer :priority
      t.string :keywords
      t.string :location
      t.string :reporter

      t.timestamps
    end
  end

  def self.down
    drop_table "<%= tech_debts_table_name %>"
  end
end
