require "test_helper"

describe Book do
  describe "relations" do
    describe "Author relations" do
      it "can set the author using an Author" do
        # Useful in our test, trow an exeption is fails.
        # ! create but if it fails stop everything.
        # From the yml fixtures
        # Symbol for the variable name that I have in the authors.yml
        author = authors(:metz)
   
        book = Book.new(title: "Fancy book")
        # Making one table talk to another
        book.author = author

        #Check that the active record recognizes the relationship
        expect(book.author_id).must_equal author.id
      end

      it "can set the author using an author id" do
        author = authors(:butler)
        book = Book.new(title: "Fancy book")

        book.author_id = author.id

        # get the author back when i get it from the book.
        expect(book.author).must_equal author
      end
    end

    describe "Genre" do
      it "only considers a genre added to a book when we have shoveled it" do
        genre = Genre.create!(name: "test finction")
        author_test = authors(:madeleine_lengle)
        book = Book.new(title: "some book", author: author_test)

        expect(book.genres.include?(genre)).must_equal false
        book.genres << genre
        expect(book.genres.include?(genre)).must_equal true
      end
    end
  end

  # Base set of test:
  describe "validations" do
    # start version available
    before do
      author_test = Author.new(name: "Test Author")
      @book = Book.new(title: "Book of testiong", author: author_test)
    end

    it "is valid when the all fields are filled" do
      #act
      result = @book.valid?
      expect(result).must_equal true
    end

    it "fails validation when there is no title" do
      @book.title = nil
      expect(@book.valid?).must_equal false
      expect(@book.errors.messages.include?(:title)).must_equal true
      expect(@book.errors.messages[:title].include?("can't be blank")).must_equal true
    end

    it "fails validations the title already exists" do
      Book.create(title: @book.title, author: @book.author)
      expect(@book.valid?).must_equal false

      expect(@book.errors.messages.include?(:title)).must_equal true
      expect(@book.errors.messages[:title].include?("has already been taken")).must_equal true
    end
  end
end
