require 'json'

module GoodReadsImport
  class Parse
    def initialize(books_json)
      @books_json = books_json
    end

    def books
      books = []
      JSON.parse(@books_json).each do |json_book|
        status = Status.new(
          has_been_read: json_book["hasBeenRead"], 
          own_the_book: json_book["ownTheBook"], 
          own_the_ebook: json_book["ownTheEBook"])
        books << Book.new(json_book["title"], json_book["author"], json_book["year"], status)
      end
      books
    end
  end
end
