class CreateWatchedListings < ActiveRecord::Migration
  def change
    create_table :watched_listings do |t|
      t.string :owner_id
      t.references :listing
    end
  end
end
