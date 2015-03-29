module GoodReadsImport
  class Book
  	def initialize(title, author, year, status)
  		@title = title
  		@author = author
  		@year = year
  		@status
  	end

    def ==(other)
      title == other.title && 
      author == other.author &&
      year == other.year &&
      status == other.status
    end
    alias :eql? :==

    def hash
      [@title, @author, @year, @status].hash
    end

    protected 

    attr_reader :title, :author, :year, :status
  end
end
