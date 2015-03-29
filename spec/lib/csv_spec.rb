require 'spec_helper'

RSpec.describe GoodReadsImport::CSV do
	context "when the there are several books" do

    let(:book1) { build(:book, :has_been_read) }
    let(:book2) { build(:book, :own_the_ebook) }
    let(:book3) { build(:book, :own_the_book) }
    let(:books) { [book1, book2, book3] }
		
    subject { GoodReadsImport::CSV.new(books) }

	  it "should prepare the headers for the CSV" do
	  	expect(subject.csv[0]).to eq(GoodReadsImport::CSV::HEADER)
	  end

    it "should prepare the book in CSV format for the first book, that is read" do
      is_read = true

      expect(subject.csv[1]).to eq([
        "'#{book1.title}'", 
        "'#{book1.author}'", 
        "'#{book1.year}'", 
        "'#{is_read}'", 
        "'#{book1.status.own_the_ebook}'", 
        "'#{book1.status.own_the_book}'"])
    end

    it "should prepare the book in CSV format for the first book, that the ebook is owned" do
      is_ebook_owned = true

      expect(subject.csv[2]).to eq([
        "'#{book2.title}'", 
        "'#{book2.author}'", 
        "'#{book2.year}'", 
        "'#{book2.status.has_been_read}'", 
        "'#{is_ebook_owned}'", 
        "'#{book2.status.own_the_book}'"])
    end

    it "should prepare the book in CSV format for the first book, that the book is owned" do
      is_book_owned = true
      
      expect(subject.csv[3]).to eq([
        "'#{book3.title}'", 
        "'#{book3.author}'", 
        "'#{book3.year}'", 
        "'#{book3.status.has_been_read}'", 
        "'#{book3.status.own_the_ebook}'",
        "'#{is_book_owned}'"])
    end
	end
end
