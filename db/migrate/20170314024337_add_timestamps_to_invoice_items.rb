class AddTimestampsToInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_items, :created_at, :datetime, precision: 0
    add_column :invoice_items, :updated_at, :datetime, precision: 0
  end
end
