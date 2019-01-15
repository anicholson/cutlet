require 'cutlet/response_mapper'
require 'test_helper'

class TestResponseMapper < Minitest::Test
  def setup
    response = [ 200, {}, ['the quick brown fox', ' jumped over the lazy dog'] ]

    @mapped = Cutlet::ResponseMapper.new(*response).to_hash
  end
  
  def test_response_code
    assert_equal(@mapped['statusCode'], 200)
  end

  def test_base64_encoding_status
    assert_equal(@mapped['isBase64Encoded'], false)
  end

  def test_body
    assert_equal(@mapped['body'], 'the quick brown fox jumped over the lazy dog')
  end
end
