class AddTimestampsToMerchants < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :created_at, :datetime, precision: 0
    add_column :merchants, :updated_at, :datetime, precision: 0
  end
end
