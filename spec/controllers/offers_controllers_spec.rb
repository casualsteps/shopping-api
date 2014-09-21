require "rails_helper"

RSpec.describe OffersController do
  let!(:publisher) { create :publisher }

  context "without api key" do
    it "fails to authenticate" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  context "with valid api key via request header" do
    it "authenticates successfully" do
      auth_with_user(publisher)
      get :index
      expect(response.status).to eq(200)
    end
  end

  context "with valid api key via get param" do
    it "authenticates successfully" do
      get :index, api_key: publisher.api_key
      expect(response.status).to eq(200)
    end
  end

  describe "#index" do

  end

  # describe "#show" do
  #   let(:offer) { create :offer_with_advertiser }
  #   before { auth_with_user(offer.advertiser) }
  #
  #   it "shows an offer" do
  #     get :show, id: offer.id
  #     expect(response.status).to eq(200)
  #
  #   end
  # end

  # context "" do
  #   before { auth_with_user(publisher) }
  #
  # end

end