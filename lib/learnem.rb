require "learnem/version"
require 'thor'
require 'json'

module Learnem
  class Flashem < Thor
    DATA_PATH = File.expand_path(File.join(File.dirname(__FILE__), "/learnem/data/data.json"))

    desc "flashem", 'Flash cards on your command line.'
    option :begin, :aliases => "-b"
    option :add, :aliases => "-a"
    long_desc <<-LONGDESC
      `flashem --begin` will begin asking your flashcard questions
      \x5`flashem --add` will prompt you for new flashcard information
    
      > $ flashem [FLAG]
    LONGDESC
    def flashem
      flashcards = JSON.parse(File.read(DATA_PATH))["cards"]
      if options[:add]
        add_card(flashcards)
      elsif options[:begin]
        ask_questions(flashcards)
      end
    end

    desc "quotes", "A nice sentiment for your day."
    option :read, :aliases => '-r'
    option :add, :aliases => '-a'
    def quotes
      quotes = JSON.parse(File.read(DATA_PATH))["quotes"]
      if options[:read]
        show_quote(quotes)
      elsif options[:add]
        add_quote(quotes)
      end
    end

    desc "main_menu", "Displays main options for the program"
    def main_menu
      flashcards = JSON.parse(File.read(DATA_PATH))["cards"]
      quotes = JSON.parse(File.read(DATA_PATH))["quotes"]

      say("Enter an option:")
      say("Begin flashem (b)\nAdd a flashcard (a)\nRead a quote (r)\nNew quote (n)\nQuit (q)")
      input = ask("> ")
      unless ['b', 'a', 'q', 'n', 'r'].include?(input)
        say("Please enter a valid option: b, a, r, n, or q. Nothing fancy.")
        main_menu
      end
      case input
      when 'b' then ask_questions(flashcards)
      when 'a' then add_card(flashcards)
      when 'n' then add_quote(quotes)
      when 'r' then show_quote(quotes)
      when 'e' then exit(1)
      end
    end

    private
    #######
    # Cards
    #######

    def add_card_to_db(cards, question, answer)
      cards[question] = answer
      db = JSON.parse(File.read(DATA_PATH))
      db["cards"] = cards
      File.open(DATA_PATH, "w") do |f|
        f.write(db.to_json)
      end
    end

    def ask_questions(flashcards)
      flashcards = flashcards.to_a.shuffle!.to_h
      flashcards.each do |question, answer|
        say("(enter 'q' at any time for more options)")
        say(question)
        input = ask("> ")
        break if input == 'q'
        say("The correct answer: #{answer}!")
        sleep(2)
      end
      main_menu
    end

    def add_card(flashcards)
      question = ask("The front of the card:")
      answer = ask("The back of the card:")
      add_card_to_db(flashcards, question, answer)
      say("That's been added!")
      main_menu
    end

    ########
    # Quotes
    ########

    def show_quote(quotes)
      quotes = quotes.to_a.shuffle
      loop do
        quote = quotes.sample
        say(quote[1])
        say(quote[0])
        input = ask("Would you like to read another? (y/n)")
        if input != 'y'
          break
        end
      end
      main_menu
    end

    def add_quote(quotes)
      quote = ask("The quote:")
      attribution = ask("Who said it?")
      add_quote_to_db(quotes, quote, attribution)
      say("That's been added!")
      main_menu
    end

    def add_quote_to_db(quotes, quote, attribution)
      quotes[attribution] = quote
      db = JSON.parse(File.read(DATA_PATH))
      db["quotes"] = quotes
      File.open(DATA_PATH, "w") do |f|
        f.write(db.to_json)
      end
    end
  end
end
