#!/usr/bin/env ruby

require 'rspec/autorun'

# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # implement your behavior here
  def full_name
    join(@first_name, @middle_name, @last_name)
    [@first_name, @middle_name, @last_name].compact.join(" ")
  end

  def full_name_with_middle_initial
    join(@first_name, initial(@middle_name), @last_name)
  end

  def initials
    initials = [@first_name, @middle_name, @last_name].map {|w| initial(w)}
    join(*initials)
  end

  private def join(*words)
    words.compact.join(" ")
  end

  private def initial(word)
    word.nil? || word.empty? ? nil : "#{word[0]}."
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      person = Person.new first_name: "Arthur", middle_name: "Conan", last_name: "Doyle"
      expect(person.full_name).to eq "Arthur Conan Doyle"
    end

    it "does not add extra spaces if middle name is missing" do
      person = Person.new first_name: "John", last_name: "Doe"
      expect(person.full_name).to eq "John Doe"
    end
  end

  describe "#full_name_with_middle_initial" do
    it "returns a full name with a middle initial" do
      person = Person.new first_name: "Arthur", middle_name: "Conan", last_name: "Doyle"
      expect(person.full_name_with_middle_initial).to eq "Arthur C. Doyle"
    end

    it "does not add extra spaces if middle name is missing" do
      person = Person.new first_name: "John", last_name: "Doe"
      expect(person.full_name_with_middle_initial).to eq "John Doe"
    end
  end

  describe "#initials" do
    it "returns only the name initials" do
      person = Person.new first_name: "Arthur", middle_name: "Conan", last_name: "Doyle"
      expect(person.initials).to eq "A. C. D."
    end

    it "does not add extra spaces if middle name is missing" do
      person = Person.new first_name: "John", last_name: "Doe"
      expect(person.initials).to eq "J. D."
    end
  end
end
