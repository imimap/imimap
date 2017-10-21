# frozen_string_literal: true

# Implements a Search
class Quicksearch < ActiveRecord::Base
  def internships(query)
    @internships = find_internships(query)
  end

  private

  # TBD did not finish cleaning up style as this search must be redone
  # anyway.
  def find_internships(query)
    internships = Internship.includes(:company).where(completed: true)
    internships = filter_by_programming_languages(internships, query)

    orientations = query[:orientation].collect(&:to_i) if query[:orientation].present?
    semesters = query[:semester].collect(&:to_i) if query[:semester].present?
    internships = internships.where(companies: {country: query[:country]}) if query[:country].present?
    internships = internships.where(orientation_id: orientations) if orientations.present?
    internships = internships.where(semester_id: semesters) if semesters.present?
    internships.uniq.sort_by(&:created_at).reverse
  end

  def filter_by_programming_languages(internships,query)
    return internships unless query[:programming_language_ids].present?
    return internships unless query[:programming_language_ids].present?

    languages = query[:programming_language_ids].collect(&:to_i)
    internships_ary = []
    programming_languages = ProgrammingLanguage.find(languages)
    programming_languages.each do |language|
      internships_ary = if internships_ary.empty?
                          language.internships.collect(&:id)
                        else
                          internships_ary & language.internships.collect(&:id)
                        end
    end
    internships.where(id: internships_ary)
  end
end
