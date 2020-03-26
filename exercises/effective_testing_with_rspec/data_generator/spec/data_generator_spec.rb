#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'date'

class DataGenerator
  def boolean_value
    [true, false].sample
  end

  def email_address_value
    domain = %w[gmail.com yahoo.com aol.com hotmail.com].sample
    username_characters = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
    username_length = rand(3..7)
    username = Array.new(username_length) { username_characters.sample }.join

    "#{username}@#{domain}"
  end

  def date_value
    Date.new(
      (1950..1999).to_a.sample,
      (1..12).to_a.sample,
      (1..28).to_a.sample
    )
  end

  def user_record
    {
      email_address: email_address_value,
      date_of_birth: date_value,
      active: boolean_value
    }
  end

  def users(count)
    Array.new(count) { user_record }
  end
end

RSpec.configure do |c|
  c.fail_fast = true
  c.formatter = 'documentation'
  c.color     = true
  c.order     = :defined
end

RSpec.describe DataGenerator do
  def be_a_boolean
    # Ruby has no Boolean class so this doesn't work.
    # Is there a way we can use `or` to combine two matchers instead?

    # be_a(Boolean)
    eq(true).or eq(false)
  end
  alias_method :a_boolean_value, :be_a_boolean

  it 'generates boolean values' do
    value = described_class.new.boolean_value
    expect(value).to be_a_boolean
  end

  def be_a_date_before_2000
    # Combine the `be_a(klass)` matcher with the `be < value` matcher
    # to create a matcher that matches dates before January 1st, 2000.

    be_a(Date).and be < Date.new(2000, 1, 1)
  end
  alias_method :a_date_before_2000, :be_a_date_before_2000

  it 'generates dates before January 1st, 2000' do
    value = described_class.new.date_value
    expect(value).to be_a_date_before_2000
  end

  def be_an_email_address
    # Pass a simple regex to `match` to define a matcher for email addresses.
    # Don't worry about complete email validation; something very simple is fine.

    match(URI::MailTo::EMAIL_REGEXP)
  end
  alias_method :an_email_address, :be_an_email_address

  it 'generates email addresses' do
    value = described_class.new.email_address_value
    expect(value).to be_an_email_address
  end

  def match_the_shape_of_a_user_record
    # Use `be_a_boolean`, `be_a_date_before_2000` and `be_an_email_address`
    # in the hash passed to `match` below to define this matcher.
    match({
      email_address: an_email_address,
      date_of_birth: a_date_before_2000,
      active: a_boolean_value
    })
  end

  it 'generates user records' do
    user = described_class.new.user_record
    expect(user).to match_the_shape_of_a_user_record
  end

  def all_match_the_shape_of_a_user_record
    # Combine the `all` matcher and `match_the_shape_of_a_user_record` here.

    all match_the_shape_of_a_user_record
  end

  it 'generates a list of user records' do
    users = described_class.new.users(4)
    expect(users).to all_match_the_shape_of_a_user_record
  end
end
