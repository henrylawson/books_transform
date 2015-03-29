require 'spec_helper'

RSpec.describe GoodReadsImport::CSV do
	context "when the there are several books" do

    let(:book1) { build(:book, :has_been_read, title: "TDD Test Driven Development", author: "Kent Beck", year: 2012) }
    let(:book2) { build(:book, :own_the_ebook, title: "The Clean Coder: A Code of Conduct for Professional Programmers", author: "Robert C. Martin", year: 2011) }
    let(:book3) { build(:book, :own_the_book, title: "The Elements of Scrum", author: "Chris Sims, Hillary Louise Johnson ", year: 2011) }
    let(:books) { [book1, book2, book3] }
		
    subject { GoodReadsImport::CSV.new(books) }

	  it "should prepare the headers for the CSV" do
	  	expect(subject.csv[0]).to eq(GoodReadsImport::CSV::HEADER)
	  end

    it "should prepare the book in CSV format for the first book, that is read" do
      is_read = true

      expect(subject.csv[1]).to eq([
        "9780321146533",
        book1.title, 
        book1.author, 
        book1.year,
        book1.year, 
        "read"])
    end

    it "should prepare the book in CSV format for the first book, that the ebook is owned" do
      is_ebook_owned = true

      expect(subject.csv[2]).to eq([
        "9780132542883",
        book2.title, 
        book2.author, 
        book2.year,
        book2.year, 
        "to-read own-the-ebook"])
    end

    it "should prepare the book in CSV format for the first book, that the book is owned" do
      is_book_owned = true
      
      expect(subject.csv[3]).to eq([
        "9780982866917",
        book3.title, 
        book3.author, 
        book3.year,
        book3.year, 
        "to-read own-the-book"])
    end
	end
end
