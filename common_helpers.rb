# frozen_string_literal: true

# The CommonHelpers module provides helper methods for data cleansing and formatting.
module CommonHelpers
  # Cleanses and formats a person's name by removing certain patterns.
  # @param name [String] The name to be cleansed and formatted.
  # @return [String] The cleansed and formatted name.
  def self.cleanse_name(name)
    # The regular expression below is used to remove specific patterns from the name:
    # Matches two or more word characters followed by a period (e.g., "Dr. ") or a period and space (e.g., "Mr. ").
    # The matched patterns are replaced with an empty string.
    name.gsub(/(\w{2,}+\.( )+)/i, '').strip.capitalize
  end
end