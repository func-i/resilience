class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  dragonfly_accessor :file

  validates :file_name, :file_uid,
    presence: true

end
