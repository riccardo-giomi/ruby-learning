#! /usr/bin/env/ruby
# frozen_string_literal: true

require_relative 'spec_helper'
require './encryptor'

RSpec.describe Encryptor do
  describe '#encrypt' do
    it 'encrypts a string' do
      expect(Encryptor.new.encrypt('hello world')).to eq 'uryyb jbeyq'
    end

    it 'encrypts only letters' do
      expect(Encryptor.new.encrypt('hello, 3 worlds!')).to eq 'uryyb, 3 jbeyqf!'
    end

    it 'keeps the characters case' do
      expect(Encryptor.new.encrypt('NaDa')).to eq 'AnQn'
    end

    it 'implements ROT13' do
      expected = 'nopqrstuvwxyzabcdefghijklm'
      encrypted = +''

      encryptor = Encryptor.new
      ('a'..'z').each { |char| encrypted << encryptor.decrypt(char) }

      expect(encrypted).to eq expected
    end
  end

  describe '#decrypt' do
    it 'decrypts a string' do
      expect(Encryptor.new.decrypt('Anqn')).to eq 'Nada'
    end

    it 'implements ROT13' do
      expected = 'nopqrstuvwxyzabcdefghijklm'
      encrypted = +''

      encryptor = Encryptor.new
      ('a'..'z').each { |char| encrypted << encryptor.decrypt(char) }

      expect(encrypted).to eq expected
    end

    it 'is the same as #encrypt for ROT 13 with only letters' do
      string = 'Hello, world'

      encryptor = Encryptor.new
      encrypted = encryptor.encrypt(string)
      expect(encryptor.encrypt(encrypted)).to eq(encryptor.decrypt(encrypted))
    end
  end
end
