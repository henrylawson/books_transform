module GoodReadsImport
  class Book
    attr_reader :title, :author, :year, :status
    
  	def initialize(title, author, year, status)
  		@title = title
  		@author = author
  		@year = year
  		@status = status
  	end

    def ==(other)
      squash == other.squash
    end
    alias :eql? :==

    def hash
      squash.hash
    end

    def squash
      [title, author, year].concat status.squash
    end
  end
end
