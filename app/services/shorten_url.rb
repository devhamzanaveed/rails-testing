class ShortenUrl
    MAX_ATTEMPTS = 5
  
    # A tiny value object so callers branch on success/failure explicitly.
    Result = Struct.new(:link, :error, keyword_init: true) do
      def success? = error.nil?
    end
  
    def self.call(original_url:)
      new(original_url:).call
    end
  
    def initialize(original_url:)
      @original_url = original_url
    end
  
    def call
      attempts = 0
      begin
        attempts += 1
        link = Link.create!(original_url: @original_url, short_code: ShortCodeGenerator.call)
        Result.new(link: link, error: nil)
      rescue ActiveRecord::RecordNotUnique
        retry if attempts < MAX_ATTEMPTS         # rare code collision → just try again
        Result.new(link: nil, error: "Could not generate a unique short code")
      rescue ActiveRecord::RecordInvalid => e
        Result.new(link: e.record, error: e.record.errors.full_messages.to_sentence)
      end
    end
  end
  