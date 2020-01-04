# frozen_string_literal: true

SeedData = Struct.new(:enrolment_number_range,
                      :with_internships,
                      :with_user,
                      :with_student) do
  def initialize(*)
    super
    self.with_student = true if with_student.nil?
  end
end

Rails.application.configure do
  config.seed_data = [SeedData.new(130_001..130_020, 0, true),
                      SeedData.new(140_001..140_020, 1, true),
                      SeedData.new(150_001..150_020, 2, true),
                      SeedData.new(160_001..160_020, 0, true, false),
                      SeedData.new(110_001..110_020, 0, false),
                      SeedData.new(120_001..120_020, 1, false)]
end
