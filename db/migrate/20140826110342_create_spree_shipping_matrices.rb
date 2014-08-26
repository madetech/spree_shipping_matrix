class CreateSpreeShippingMatrices < ActiveRecord::Migration
  def change
    create_table :spree_shipping_matrices do |t|
      t.string :name
      t.timestamps
    end
  end
end
