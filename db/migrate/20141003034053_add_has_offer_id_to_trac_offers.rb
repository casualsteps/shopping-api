class AddHasOfferIdToTracOffers < ActiveRecord::Migration
  def change
    add_column :trac_offers, :has_offer_id, :integer
  end
end
