require 'test_helper'

class VendeoTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Vendeo.new.valid?
  end
end
