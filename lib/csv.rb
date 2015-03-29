require 'httparty'

module GoodReadsImport
  class CSV
    HEADER = ["ISBN", "Title", "Author", "Year Published", "Original Publication Year", "Bookshelves"]

    def initialize(books)
      @books = books
    end

    def csv
      csv_rows = [HEADER]
      @books.each do |book|
        bookshelf = determine_bookshelf book.status
        isbn = determine_isbn book
        csv_rows << [isbn, book.title, book.author, book.year, book.year, bookshelf]
      end
      csv_rows
    end

    private

    def determine_isbn(book)
      puts "Searching for #{book.author} - #{book.title}"
      attempt_number = 0
      loop do
        attempt_number += 1
        isbn = try_get_isbn book, attempt_number
        break if isbn || attempt_number > 5
        sleep 5
      end
    end

    def try_get_isbn(book, attempt_number)
      begin
        query = URI::encode("#{book.author} #{book.title} #{book.year}".gsub(/[^0-9a-z ]/i, ''))
        search_url = "https://www.googleapis.com/books/v1/volumes?q=" + query
        response = HTTParty.get(search_url)
        result = JSON.load(response.body)
        result["items"][0]["volumeInfo"]["industryIdentifiers"].select { |obj| obj["type"] == "ISBN_13" }[0]["identifier"]
      rescue 
        puts "ATTEMPT #{attempt_number} | Failed to get ISBN for #{search_url}"
      end
    end

    def determine_bookshelf status
      bookshelf = ""
      bookshelf += status.has_been_read ? "read " : "to-read "
      bookshelf += "own-the-ebook " if status.own_the_ebook
      bookshelf += "own-the-book " if status.own_the_book
      bookshelf.strip
    end
  end
end
