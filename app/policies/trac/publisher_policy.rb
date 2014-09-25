class Trac::PublisherPolicy < ApplicationPolicy
  def show?
    advertiser_signed_in?
  end
end