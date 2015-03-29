#!/usr/bin/env ruby

require 'csv'
require_relative 'csv'
require_relative 'parse'
require_relative 'book'
require_relative 'status'

books_json_file = $ARGV[0]
books_csv_file  = $ARGV[1]

parser = GoodReadsImport::Parse.new File.read books_json_file
books_csv = GoodReadsImport::CSV.new(parser.books)
CSV.open(books_csv_file, "wb") do |csv|
  books_csv.csv.each { |row| csv << row }
end