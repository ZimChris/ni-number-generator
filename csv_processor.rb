require 'csv'
require_relative 'ninumber_generator'
require_relative 'common_helpers'

# The CSVProcessor class handles processing of a CSV file and generating NI numbers.
class CSVProcessor
  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
  end

  # Processes the input CSV file, generates NI numbers, and displays counts per country.
  def process
    create_csv_file
    countries = Hash.new(0)

    CSV.foreach(@input_file, headers: true) do |row|
      # Determine the country, default to 'Non-UK' if not in the specified list
      country = row['Country of Birth'].strip
      country = 'Non-UK' unless ['Wales', 'England', 'Scotland', 'Northern Ireland'].include?(country)

      # Generate the NI number using the NINumberGenerator class
      ni_generator = NINumberGenerator.new(row)
      ni_number = ni_generator.generate

      # Add the row with the generated NI number to the output CSV file
      add_row_to_csv(row, ni_number)

      # Update the count for the respective country
      countries[country] += 1
    end

    # Display the count of NI numbers per country
    display_ni_count_per_country(countries)
  rescue Errno::ENOENT => e
    puts e.message
    exit(1)
  end

  # Creates a new CSV file with headers.
  def create_csv_file
    CSV.open(@output_file, 'w') do |csv|
      csv << ['First names', 'Last name', 'Year of Birth', 'Country of Birth', 'National Insurance Number']
    end
  end

  # Adds a row with NI number to the output CSV file.
  # @param row [CSV::Row] The row from the input CSV file.
  # @param ni_number [String] The generated NI number.
  def add_row_to_csv(row, ni_number)
    CSV.open(@output_file, 'a') do |csv|
      csv << [
        CommonHelpers.cleanse_name(row['First names']),
        row['Last name'].strip,
        row['Date of Birth'][0, 4],
        row['Country of Birth'].strip,
        ni_number
      ]
    end
  end

  # Displays the count of NI numbers per country.
  # @param countries [Hash] A hash containing country names as keys and counts as values.
  def display_ni_count_per_country(countries)
    countries.each do |country, count|
      puts "#{country}: #{count}"
    end
  end
end