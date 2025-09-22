class Contestant < ApplicationRecord
  attribute :eliminated, :boolean, default: false

  belongs_to :season

  validates :name, presence: true, uniqueness: { scope: :season_id }
  validates :eliminated, inclusion: { in: [true, false] }
end
