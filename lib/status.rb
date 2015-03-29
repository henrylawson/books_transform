module GoodReadsImport
  class Status
  	def initialize(has_been_read: false, own_the_book: false, own_the_ebook: false)
  		@has_been_read = is_true has_been_read
  		@own_the_book = is_true own_the_book
  		@own_the_ebook = is_true own_the_ebook
  	end

    def squash
      [has_been_read, own_the_book, own_the_ebook]
    end

    protected

    attr_reader :has_been_read, :own_the_book, :own_the_ebook

    private

    def is_true(value)
      value.to_s.downcase == "true"
    end
  end
end
