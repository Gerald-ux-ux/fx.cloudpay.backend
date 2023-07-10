class User < ApplicationRecord
  attribute :name, :string
  has_secure_password
  has_many :collections, dependent: :destroy
  has_many :balances, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :openings, dependent: :destroy
  has_many :closings, dependent: :destroy
  has_many :disbursments, dependent: :destroy
  attr_accessor :formatted_date
end
