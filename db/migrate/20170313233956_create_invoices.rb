class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :customer_id
      t.string :merchant_id
      t.string :status

    end
  end
end
