class ChangeCustomerIdAndMerchantIdToIntegerOnInvoices < ActiveRecord::Migration[5.0]
  def change
    change_column :invoices, :merchant_id, 'integer USING CAST(merchant_id AS integer)'
    change_column :invoices, :customer_id, 'integer USING CAST(customer_id AS integer)'
  end
end
