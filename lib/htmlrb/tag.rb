# frozen_string_literal: true

module Htmlrb
  class Tag
    attr_reader :html_parts

    def initialize
      @html_parts = []
    end

    def doctype
      @html_parts << "<!DOCTYPE html>"
    end

    def method_missing(method_name, content_or_options = "", options = {}, &block)
      options = content_or_options if content_or_options.is_a?(Hash)
      elm_name = method_name.to_s.gsub('_', '-')

      @html_parts << "<#{elm_name}"

      @html_parts << " " unless options.empty?
      @html_parts << options.map do |key, val|
        attr_name = key.to_s.gsub('_', '-')
        "#{attr_name}=\"#{val}\""
      end.join(" ")

      @html_parts << ">"

      if block
        @html_parts << block.call(self)
      elsif content_or_options.is_a?(String)
        @html_parts << content_or_options
      end

      if block || content_or_options.is_a?(String)
        @html_parts << "</#{elm_name}>"
      end

      nil
    end
  end
end
