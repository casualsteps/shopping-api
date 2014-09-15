require "rails_helper"

RSpec.describe Trac::Offer do
  describe "#expire" do
    it "expires correctly" do
      expired_one = Trac::Offer.create! expires_on: Date.today - 1.day
      not_expired_one = Trac::Offer.create! expires_on: Date.today + 1.day
      Trac::Offer.expire

      expect(Trac::Offer.valid).to eq [not_expired_one]
      expect(not_expired_one.reload.deleted?).to be false
      expect(expired_one.reload.deleted?).to be true
    end
  end
end