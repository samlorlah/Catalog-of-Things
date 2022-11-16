require_relative './properties/label'
require_relative './properties/genre'
require_relative './properties/author'
require_relative './io-files/save_data'
require_relative './io-files/read_data'
require_relative './things/book'
require_relative './things/music_album'

class App
  attr_reader :books, :labels, :music_albums, :genres

  def initialize
    @books = ReadData.read_books
    @games = []
    @music_albums = []
    @labels = ReadData.read_labels
    @genres = []
    @music_albums = []
    @authors = []
  end

  def quit_app
    SaveData.save_books(@books)
    SaveData.save_labels(@labels)
    puts 'Thank you for using this app! Now exiting...😊'
    exit
  end

  def add_book
    label = add_label('Book')
    author = add_author
    genre = add_genre('Book\'s')
    # Books props
    print 'What\'s the cover state of the book? [good/bad]: '
    cover_state = gets.chomp.downcase
    print 'Who is the publisher? '
    publisher = gets.chomp
    print 'What\'s the publishing date? [year/month/day] (e.g 1937/11/12): '
    published_date = gets.chomp
    book = Book.new(publisher, cover_state, published_date)
    label.add_item(book)
    genre.add_item(book)
    author.add_item(book)

    @books << book
    @labels << label
    @genres << genre
    @authors << author
    puts "\nThe book '#{label.title}' by #{author.first_name} #{author.last_name} was created successfully! 👍"
  end

  def add_label(item_type)
    # Label props
    print "Title of the #{item_type}: "
    title = gets.chomp
    print "Color of the #{item_type}: "
    color = gets.chomp
    Label.new(title, color)
  end

  def add_genre(item_type)
    # Genre prop
    print "#{item_type} genre: "
    genre_name = gets.chomp
    Genre.new(genre_name)
  end

  def add_author
    # Author props
    print 'Author\'s first name: '
    first_name = gets.chomp
    print 'Author\'s last name: '
    last_name = gets.chomp
    Author.new(first_name, last_name)
  end

  def list_all_books
    if @books.empty?
      puts 'The book list is empty, add some books...😀'
    else
      puts "Books list, count(#{@books.count})📚 :\n\n"
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Title: '#{book.label.title}'",
             "   Author: #{book.author.first_name}, #{book.author.last_name} ",
             "   Publisher: #{book.publisher}",
             "   Cover State: #{book.cover_state}"
      end
    end
  end

  def list_all_labels
    if @labels.empty?
      puts 'The label list is empty, add some items...😀'
    else
      puts "Labels list, count(#{@labels.count})🏷️ :\n\n"
      @labels.each_with_index do |label, index|
        puts "#{index + 1}) Title: '#{label.title}', Color / Studio: #{label.color}"
      end
    end
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts "The music album list is empty, add some music albums...\u{1F3B9}"
    else
      puts "Music albums list, count(#{@music_albums.count})👀 :\n\n"
      @music_albums.each_with_index do |music_album, index|
        puts "#{index + 1}) Title: '#{music_album.label.title}, " \
             "Genre: '#{music_album.genre.name}, " \
             "Is it on Spotify?: #{music_album.on_spotify}"
      end
    end
  end

  def add_music_album
    music = create_music_album
    label = create_music_label
    genre = create_music_genre
    musician = create_musician
    puts "\n \n Music Album created successfully \n \n"
    @music_albums << music
    @labels << label
    @genres << genre
    @authors << musician

    label.add_item(music)
    genre.add_item(music)
    musician.add_item(music)
    # save_music_album(label_title, color, genre_name, musician_firstname, musician_lastname)
  end

  def on_spotify?
    print 'Is the Music Album on Spotify? [Y/N]: '
    is_spotify = gets.chomp.downcase
    case is_spotify
    when 'y'
      true
    when 'n'
      false
    else
      puts 'Invalid Selection. Please enter \'y\', \'Y\' or \'n\', \'N\'!'
      on_spotify?
    end
  end

  def create_music_album
    on_spotify = on_spotify?
    print 'What\'s the publishing date? [year/month/day] (e.g 1937/11/12): '
    published_date = gets.chomp
    MusicAlbum.new(on_spotify, published_date)
  end

  def create_music_label
    print 'What\'s the music title of the music? '
    label_title = gets.chomp
    print 'Where\'s the studio of the music label? '
    color = gets.chomp
    Label.new(label_title, color)
  end

  def create_music_genre
    print 'What\'s the genre of the music? '
    genre_name = gets.chomp
    Genre.new(genre_name)
  end

  def create_musician
    print 'What is the firstname of the musician? '
    musician_firstname = gets.chomp
    print 'What is the lastname of the musician? '
    musician_lastname = gets.chomp
    Author.new(musician_firstname, musician_lastname)
  end

  def
  # def save_music_album(on_spotify, published_date, label_title, color, genre_name, musician_firstname,
  #                      musician_lastname)
  #   music = MusicAlbum.new(on_spotify, published_date)
  #   label = Label.new(label_title, color)
  #   genre = Genre.new(genre_name)
  #   musician = Author.new(musician_firstname, musician_lastname)

  #   @music_albums << music
  #   @labels << label
  #   @genres << genre
  #   @authors << musician

  #   label.add_item(music)
  #   genre.add_item(music)
  #   musician.add_item(music)
  # end

  def(_list_all_music_albums)
    if @music_albums.empty?
      puts 'The music album list is empty, add some albums...😀'
    else
      puts "Music Albums list, count(#{@music_albums.count}) \u{1F3B9} :\n\n"
      @music_albums.each_with_index do |music, index|
        puts "#{index + 1}) Title: '#{music.label.title}', Genre: #{music.genre.name}"
      end
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'The genre list is empty, add some genres...😀'
    else
      puts "Genres list, count(#{@genres.count}) :\n\n"
      @genres.each_with_index do |genre, index|
        puts "#{index + 1}) Name: '#{genre.name}'"
      end
    end
  end
end
