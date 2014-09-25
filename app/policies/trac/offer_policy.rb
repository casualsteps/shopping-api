class Trac::OfferPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    advertiser_signed_in?
  end
end