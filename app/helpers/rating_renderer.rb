# frozen_string_literal: true

# TBD: will we still need this?
class RatingRenderer
  attr_reader :rating

  def initialize(rating, template)
    rating = 0 if rating.nil?

    @rating = rating
    @template = template
  end

  def render_star_fields
    content_tag :ul, create_star_fields
  end

  def create_star_fields
    (1..5).map do |i|
      if i <= rating
        create_rating_field(i, 'on')
      else
        create_rating_field(i)
      end
    end.join.html_safe
  end

  def create_rating_field(id, klass = '')
    content_tag :li,
                nil,
                class: "rating_star #{klass}",
                data: { rating_id: id.to_s }
  end

  # def method_missing(*args, &block)
  #   @template.public_send(*args, &block)
  # end
  #
  # def respond_to_missing?(method, *)
  #   method =~ /.*/ || super
  # end
end
