class User < ApplicationRecord
has_secure_password
has_many :collections
has_many :balances
attr_accessor :formatted_date

end
