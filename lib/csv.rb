module GoodReadsImport
  class CSV
    HEADER = ["title", "author", "year", "has_been_read", "own_the_ebook", "own_the_book"]

    def initialize(books)
      @books = books
    end

    def csv
      csv_rows = [HEADER]
      @books.each do |book|
        csv_rows << book.squash.map { |record| "'#{record}'" }
      end
      csv_rows
    end
  end
end
