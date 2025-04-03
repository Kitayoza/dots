# frozen_string_literal: true

require_relative "test_helper"

class TestDots < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Dots::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

end
