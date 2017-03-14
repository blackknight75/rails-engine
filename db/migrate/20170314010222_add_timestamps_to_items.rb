class AddTimestampsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :created_at, :datetime, precision: 0
    add_column :items, :updated_at, :datetime, precision: 0
  end
end
