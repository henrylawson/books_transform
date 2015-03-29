module GoodReadsImport
  class CSV
    HEADER = ["Title", "Author", "Year Published", "Original Publication Year", "Bookshelves"]

    def initialize(books)
      @books = books
    end

    def csv
      csv_rows = [HEADER]
      @books.each do |book|
        bookshelf = determine_bookshelf book.status
        csv_rows << [book.title, book.author, book.year, book.year, bookshelf]
      end
      csv_rows
    end

    private

    def determine_bookshelf status
      bookshelf = ""
      bookshelf += status.has_been_read ? "read " : "to-read "
      bookshelf += "own-the-ebook " if status.own_the_ebook
      bookshelf += "own-the-book " if status.own_the_book
      bookshelf.strip
    end
  end
end
