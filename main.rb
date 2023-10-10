# Import necessary modules and classes
require_relative 'common_helpers'
require_relative 'ninumber_generator'
require_relative 'csv_processor'

# Create an instance of CSVProcessor and start processing the CSV file.

input_file = '310157 HEO SDET - people data set.csv'
output_file = 'people data set with NI numbers.csv'
processor = CSVProcessor.new(input_file, output_file)
processor.process