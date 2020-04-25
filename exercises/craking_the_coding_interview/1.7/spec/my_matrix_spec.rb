# frozen_string_literal: true

require_relative '../my_matrix'
require_relative 'support/right_rotation_90_degrees_shared_examples'
require_relative 'support/left_rotation_90_degrees_shared_examples'

RSpec.describe MyMatrix do

  context '#rotate_right' do
    context 'with valid parameters' do
      include_examples '90 degrees right rotation'
    end
  end

  context '#rotate_left' do
    context 'with valid parameters' do
      include_examples '90 degrees left rotation'
    end
  end
end
