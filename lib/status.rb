module GoodReadsImport
  class Status
  	def initialize(has_been_read: false, own_the_book: false, own_the_ebook: false)
  		@has_been_read = has_been_read
  		@own_the_book = own_the_book
  		@own_the_ebook = own_the_ebook
  	end

  	def ==(other)
      has_been_read == other.has_been_read && 
      own_the_book == other.own_the_book &&
      own_the_ebook == other.own_the_ebook
    end
    alias :eql? :==

    def hash
      [@has_been_read, @own_the_book, @own_the_ebook].hash
    end

    protected

    attr_reader :has_been_read, :own_the_book, :own_the_ebook
  end
end
