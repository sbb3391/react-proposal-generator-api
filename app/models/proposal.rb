class Proposal < ApplicationRecord
  has_many :machines, dependent: :destroy
end
