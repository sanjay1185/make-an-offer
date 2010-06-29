class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :offer_price
      t.string  :offer_message
      t.string  :shop
      t.integer :product_id
      t.timestamps
      t.date    :created_at
    end
  end

  def self.down
    drop_table :offers
  end
end
