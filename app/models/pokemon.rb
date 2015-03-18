class Pokemon < ActiveRecord::Base
    validates :name, presence: true, length: {minimum: 3}
    validates :types, presence: true
    mount_uploader :image, ImageUploader
end
