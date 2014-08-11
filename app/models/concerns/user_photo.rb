module UserPhoto
  extend ActiveSupport::Concern

  SIZE = {
    large:   '1024x1024>',
    normal:  '400x400>',
    small:   '100x100>',
    avatar:  '30x30#'
  }

  included do
    dragonfly_accessor :photo
    validates_property :format, of: :photo, in: ['jpeg', 'png', 'gif']
    validates_property :width, of: :photo, in: (0..20000), message: "File size exeed the limi from"
  end

  def thumb size = :normal
    size = UserPhoto::SIZE[size]
    return photo unless photo_stored?

    photo.thumb(size) if photo_stored?
  end

end
