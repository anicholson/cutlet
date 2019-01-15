module Cutlet
  class ResponseMapper
    def initialize(status, headers, body)
      @status = status
      @headers = headers
      @body = body
    end

    def to_hash
      {
        'isBase64Encoded' => false,
        'statusCode'      => status,
        'headers'         => {},
        'multiValueHeaders' => {},
        'body' => body.join('')
      }
    end

    def to_json
      to_hash
    end
    
    private

    attr_reader :status, :headers, :body
  end
end
