module ImtRb
  module Helper
    def self.included(by)
      by.extend(self)
    end

    def hexdigest(str)
      Digest::Keccak256.new.hexdigest(str)
    end

    def digest(str)
      Digest::Keccak256.new.digest(str)
    end

    def to_binary(str)
      [str].pack("H*")
    end

    def to_hex(binary_str)
      binary_str.unpack1("H*")
    end
  end
end
