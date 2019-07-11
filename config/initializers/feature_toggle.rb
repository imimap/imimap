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

FT = FeatureToggle.new.tap do |ft|
  ft.for(:student_can_edit_internship) do |current_user|
    # \d in third place to allow for FactoryBot sequence
    /s0[1-3]\d{3}[0-8]@htw-berlin.de/.match?(current_user.email)
  end

  ft.for(:student_can_print_internship_application) do |current_user|
    # \d in third place to allow for FactoryBot sequence
    /s0[1-3]\d{3}[0-8]@htw-berlin.de/.match?(current_user.email)
  end
end
