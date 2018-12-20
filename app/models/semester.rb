# frozen_string_literal: true

# The Semester the Internship is assigned to
class Semester < ApplicationRecord
  CODE = { 'SS': 1, 'WS': 2 }.freeze
  has_many :internships
  before_save :sid_or_name

  def sid_or_name
    sid = name2sid(name) if if sid.nil? && !name.nil?

    #name.nil? && !sid.nil?


  end

  private

  def name2sid(name)
    m = /(WS|SS) (\d\d)(\/\d\d)?/.match(name)
    raise "couldn't match #{name}" unless m
    year = 2000 + m[2].to_i
    puts "semester: m#{m[1]}m"
    puts "semester: #{CODE.inspect}"
    puts "semester: #{CODE[m[1]]}"
    summer_or_winter = CODE[m[1].to_sym]
    raise "invalid semester marker in #{name}" unless summer_or_winter
    year + summer_or_winter / 10
  end
end
