require "rails_helper"

RSpec.describe Trac::Offer do
  describe "#expire" do
    let!(:expired_one) { create :offer, expires_on: Date.today - 1.day }
    let!(:not_expired_one) { create :offer, expires_on: Date.today + 1.day }

    it "expires correctly" do
      expect { Trac::Offer.expire }.to change { Trac::Offer.valid.count }.by(-1)

      expect(Trac::Offer.valid).to eq [not_expired_one]
      expect(not_expired_one.reload.deleted?).to be false
      expect(expired_one.reload.deleted?).to be true
    end
  end
end