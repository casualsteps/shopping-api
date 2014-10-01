class Trac::AdvertiserPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    publisher_signed_in?
  end
end