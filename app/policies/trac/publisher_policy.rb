class Trac::PublisherPolicy < ApplicationPolicy
  def show?
    advertiser_signed_in?
  end

  def update?
    publisher_signed_in? && user.id == record.id
  end
end