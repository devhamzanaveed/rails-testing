class ShortCodeGenerator
    DEFAULT_LENGTH = 7

    def self.call(length: DEFAULT_LENGTH)
      SecureRandom.alphanumeric(length)
    end
end
