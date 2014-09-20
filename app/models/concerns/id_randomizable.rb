# Makes model's ID to 8 digits of random number
module IdRandomizable
  def self.included(base)
    base.before_create :randomize_id
  end

  protected

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000_000 - 10_000_000) + 10_000_000
    end while self.class.where(id: id).exists?
  end
end