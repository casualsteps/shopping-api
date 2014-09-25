class Trac::CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    publisher_signed_in? || (advertiser_signed_in? && user.id == record.advertiser_id)
  end

  def update?
    advertiser_signed_in?
  end
end