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

  def list
    @flags.keys
  end
end

# \d in third place to allow for FactoryBot sequence
TEST_EMAIL_REGEXP = /s01[1-4]\d*@htw-berlin.de/.freeze

FT = FeatureToggle.new.tap do |ft|
  ft.for(:postponement) do |current_user|
    current_user.feature_on?(:student_can_edit_internship)
  end
end
#  ft.for(:student_can_edit_internship) do |_current_user|
# TEST_EMAIL_REGEXP.match?(current_user.email) ||
#  current_user.feature_on?(:student_can_edit_internship)
#  end

# to check:  FT.on?(:student_can_edit_internship, current_user)
# end
