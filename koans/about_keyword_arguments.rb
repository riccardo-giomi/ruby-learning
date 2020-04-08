require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, 'two'], method_with_keyword_arguments
    assert_equal ['one', 'two'], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise (ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    assert_match(/wrong number of arguments/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments always have a default value, making them optional to the caller

  # Not true, after version 2.1, where the form `method_name(mandatory_arg:)` was introduced:
  unless before_ruby_version("2.1")
    def method_with_mandatory_keyword_argument(one:)
      [one]
    end


    def test_keyword_arguments_defined_without_a_default_are_mandatory
      exception = assert_raise (ArgumentError) do
        method_with_mandatory_keyword_argument
      end
      assert_match(/missing keyword/, exception.message)
    end
  end
end
