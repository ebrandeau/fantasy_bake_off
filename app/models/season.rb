class Season < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :contestants, dependent: :destroy
  has_many :overall_picks, dependent: :destroy

  belongs_to :winner_contestant, class_name: "Contestant", optional: true

  validates :year, presence: true
  validates :active, inclusion: { in: [true, false] }
end
