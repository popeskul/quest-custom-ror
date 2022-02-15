# frozen_string_literal: true

# GenerateRandomToken
module GenerateRandomToken
  def self.call
    SecureRandom.hex(10)
  end
end
