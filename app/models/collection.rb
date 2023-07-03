class Collection < ApplicationRecord
  belongs_to :user
attr_accessor :formatted_date
end
