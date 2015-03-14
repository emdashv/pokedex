class Pokemon < ActiveRecord::Base
    mount_uploader :image, ImageUploader
end
