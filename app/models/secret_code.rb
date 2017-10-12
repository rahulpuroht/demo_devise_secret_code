class SecretCode < ApplicationRecord
  belongs_to :user, optional: true

  def self.generate_codes(count)
  	count.times{
  		self.create(code: (SecureRandom.hex(4)))
  	}
  end
end
