class CreateSpreeShippingMatrixRules < ActiveRecord::Migration
  def change
    create_table :spree_shipping_matrix_rules do |t|
      t.references :shipping_matrix, index: true
      t.references :role, index: true
      t.decimal :min_line_item_total, precision: 5, scale: 2, null: false
      t.decimal :amount, precision: 5, scale: 2, null: false
    end
  end
end
