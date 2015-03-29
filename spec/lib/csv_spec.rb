require 'spec_helper'

describe GoodReadsImport::CSV do
	context "when the there " do

    let (:books) {  }
		
    subject { GoodReadsImport::Parse.new(BOOKS_JSON) }

	  it "should return a blank instance" do
	  	expected_status = GoodReadsImport::Status.new(
	  		has_been_read: true, 
	  		own_the_book: false, 
	  		own_the_ebook: true)
	  	expected_book = GoodReadsImport::Book.new("The Agile Samurai", "Jonathan Rasmusson", "2010", expected_status)

	    expect(subject.books.first).to eq(expected_book)
	  end

	  it "should return a blank instance" do
	    expected_status = GoodReadsImport::Status.new(
	  		has_been_read: true, 
	  		own_the_book: false, 
	  		own_the_ebook: true)
	  	expected_book = GoodReadsImport::Book.new("Don't Make Me Think: A Common Sense Approach to Web Usability", "Krug Steve", "2009", expected_status)

	    expect(subject.books.last).to eq(expected_book)
	  end
	end
end
