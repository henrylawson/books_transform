FactoryGirl.define do
  factory :book, class: GoodReadsImport::Book do
    title Faker::Name.title
    author Faker::Name.name 
    year Faker::Date.between(DateTime.now, Date.parse("1920-01-01")).year.to_s
    status GoodReadsImport::Status.new(has_been_read: false, own_the_ebook: false, own_the_book: false)

    initialize_with { new(title, author, year, status) }

    trait :has_been_read do
      status GoodReadsImport::Status.new(has_been_read: true, own_the_ebook: false, own_the_book: false)
    end

    trait :own_the_ebook do
      status GoodReadsImport::Status.new(has_been_read: false, own_the_ebook: true, own_the_book: false)
    end

    trait :own_the_book do
      status GoodReadsImport::Status.new(has_been_read: false, own_the_ebook: false, own_the_book: true)
    end
  end
end