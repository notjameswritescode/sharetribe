require 'spec_helper'

describe WatchedListingsController, type: :controller do
  before(:each) do
    @community = FactoryGirl.create(:community)
    @request.host = "#{@community.ident}.lvh.me"
    @request.env[:current_marketplace] = @community
    @person = FactoryGirl.create(:person)
    @community.members << @person

    sign_in_for_spec(@person)

    @listing = FactoryGirl.create(:listing)
  end

  context "#create" do
    it "should add a listing to the persons watch list" do
      expect{ post :create, listing_id: @listing.id }.to change{ @person.watched_listings.count }
      expect(@person.watched_listings.count).to eq(1)
    end
  end

  context "#destroy" do
    it "should remove a listing to the persons watch list" do
      @person.watched_listings.create(listing: @listing)

      expect(@person.watched_listings.count).to eq(1)
      expect{ delete :destroy, listing_id: @listing.id }.to change{ @person.watched_listings.count }
      expect(@person.watched_listings.count).to eq(0)
    end
  end
end
