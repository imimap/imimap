# frozen_string_literal: true

# superclass for imimap uploaders
class Uploader < CarrierWave::Uploader::Base
  def store_dir
    format('uploads/%<env>s/%<clazz>s/%<mount>s/%<model>s',
           env: Rails.env,
           clazz: model.class.to_s.underscore,
           mount: mounted_as,
           model: model.id)
  end
end
