# frozen_string_literal: true

require "htmlrb/tag"

module Htmlrb
  class Builder
    def initialize
      @tag = Htmlrb::Tag.new
      yield @tag
    end

    def build
      @tag.str
    end
  end
end
