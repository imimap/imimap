# frozen_string_literal: true

# found this super-simple and elegant FeatureToggle in
# https://blog.arkency.com/2015/11/simple-feature-toggle-for-rails-app/
class FeatureToggle
  def initialize
    @flags = {}
  end

  def with(name, *args)
    yield if on?(name, *args)
  end

  def on?(name, *args)
    @flags.fetch(name, proc { |*_args| false }).call(*args)
  end

  def for(name, &block)
    @flags[name] = block
  end
end

# \d in third place to allow for FactoryBot sequence
TEST_EMAIL_REGEXP = /s01[1-4]\d*@htw-berlin.de/.freeze

FT = FeatureToggle.new.tap do |ft|
  ft.for(:student_can_edit_internship) do |current_user|
    TEST_EMAIL_REGEXP.match?(current_user.email)
  end

  ft.for(:student_can_print_internship_application) do |current_user|
    TEST_EMAIL_REGEXP.match?(current_user.email)
  end
end
