# frozen_string_literal: true

class QuicksearchesController < ApplicationController
  def index
    @quicksearch = Quicksearch.new

    @companies = []

    @orientations_ary = []

    @language_ary = []

    params[:country].delete_if(&:empty?) if params[:country].present?
    params[:semester].delete_if(&:empty?) if params[:semester].present?
    params[:programming_language_ids].delete_if(&:empty?) if params[:programming_language_ids].present?
    params[:orientation].delete_if(&:empty?) if params[:orientation].present?

    if !params[:orientation].present? && !params[:semester].present? && !params[:programming_language_ids].present? && !params[:country].present?
      @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order('internships.created_at DESC')
    else
      @internships = @quicksearch.internships(params)
    end

    @internships = @internships.first(5)

    @internships.each do |i|
      i.programming_languages.each do |p|
        @language_ary << p
      end
    end
    @programming_languages = @language_ary.uniq

    @orientations_ary = @internships.collect(&:orientation)
    @orientations = @orientations_ary.uniq.map { |o| [o.name, o.id] }

    @companies = @internships.collect(&:company)

    @semesters = @internships.collect(&:semester).map { |s| [s.name, s.id] }

    @internships_size = @internships.size

    @bool = Internship.where(completed: true).size == @internships_size

    @countries = @companies.collect(&:country)

    ary = []
    @countries.uniq.each do |x|
      ary << { name: x, count: @countries.count(x) }
    end
    @data_country = ary

    ary = []
    @language_ary.uniq.each do |x|
      ary << { name: x.name, count: (@language_ary.count(x).to_f / @internships_size * 100).to_i }
    end
    @data_language = ary

    ary = []
    @orientations_ary.uniq.each do |x|
      ary << { name: x.name, count: @orientations_ary.count(x) }
    end
    @data_orientation = ary

    @countries = @countries.uniq
    @semesters = @semesters.uniq

    respond_to do |format|
      format.js { render layout: false, locals: { pins: @pins, internships: @internships } }
    end
  end
end
