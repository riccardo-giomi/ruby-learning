# frozen_string_literal: true

require_relative '../rotate_matrix'
require_relative 'support/right_rotation_90_degrees_shared_examples'
require_relative 'support/left_rotation_90_degrees_shared_examples'

RSpec.describe RotateMatrix do

  context '#call' do
    context 'with valid parameters' do
      include_examples '90 degrees right rotation'
      include_examples '90 degrees left rotation'
    end
  end
end
