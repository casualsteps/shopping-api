class Trac::AdvertiserPolicy < ApplicationPolicy
  def show?
    publisher_signed_in?
  end
end