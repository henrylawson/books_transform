require 'spec_helper'

RSpec.describe GoodReadsImport::Parse do
	context "when there are multiple well formed JSON books" do
		BOOKS_JSON = <<JSON
[
  {
    "title": "The Agile Samurai",
    "cover": "http://bks9.books.google.com/books?id=KjmXSQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
    "author": "Jonathan Rasmusson",
    "year": "2010",
    "id": "50d9dd64-e9c5-ba8c-c753-e1f30e969b8c",
    "priority": {
      "all": "244",
      "wishlist": "14",
      "read": "63"
    },
    "hasBeenRead": "true",
    "ownTheBook": "false",
    "ownTheEBook": "true",
    "notes": "",
    "index": "13"
  },
  {
    "title": "Don't Make Me Think: A Common Sense Approach to Web Usability",
    "cover": "http://bks7.books.google.com/books?id=HfDxMv484koC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
    "author": "Krug Steve",
    "year": "2009",
    "id": "88d639e6-6365-dbd1-fc4d-2a16f97867c4",
    "priority": {
      "all": "235",
      "wishlist": "28",
      "upcoming": "1",
      "read": "60"
    },
    "hasBeenRead": "true",
    "ownTheBook": "false",
    "ownTheEBook": "true",
    "notes": "",
    "index": "22"
  }
]
JSON

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
