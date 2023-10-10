require 'csv'
require_relative 'common_helpers'

# The NINumberGenerator class generates National Insurance (NI) numbers based on given data.
class NINumberGenerator
  COUNTRIES = {
    'Wales' => 'W',
    'England' => 'E',
    'Scotland' => 'S',
    'Northern Ireland' => 'N',
    'Non-UK' => 'O'
  }.freeze

  # Initialises the NINumberGenerator with a row of data.
  # @param row [Array<String>] The row containing person data.
  def initialize(row)
    @row = row
    @ni_number = []
  end

  # Generates a National Insurance (NI) number based on the provided data.
  # @return [String] The generated NI number.
  def generate
    # Cleansing and formatting first name
    @ni_number << CommonHelpers.cleanse_name(@row['First names'])[0]
    @ni_number << @row['Last name'].upcase.strip[0]
    @ni_number << [' ', ''].sample # Optional space

    # Extracting and formatting year of birth
    @ni_number << @row['Date of Birth'][2, 2]
    @ni_number << [' ', ''].sample # Optional space

    # Generating a random middle part of the NI number
    @ni_number << rand(1000..9999)
    @ni_number << [' ', ''].sample # Optional space

    # Determining the country code part of the NI number
    country = @row['Country of Birth'].strip
    @ni_number << if COUNTRIES.key?(country)
                    COUNTRIES[country]
                  else
                    COUNTRIES['Non-UK']
                  end
    @ni_number.join
  end
end
