class AddTimestampsToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :created_at, :datetime, precision: 0
    add_column :transactions, :updated_at, :datetime, precision: 0
  end
end
