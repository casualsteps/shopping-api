# when include TokenGeneratable, it fills model's api_key with 10 byte hex token before creation.
module TokenGeneratable
  def self.included(base)
    base.before_create :generate_token
  end

  protected

  def generate_token
    begin
      self.api_key = token
    end while self.class.exists?("#{self.class.to_s.demodulize.downcase}_api_key".to_sym => api_key)
  end
  alias refresh_token generate_token

  def token
    SecureRandom.hex(10)
  end
end