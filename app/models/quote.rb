class Quote < ApplicationRecord
    has_many :line_item_dates, dependent: :destroy
    belongs_to :company
    has_many :line_items, through: :line_item_dates

    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # after_create_commit -> { broadcast_prepend_later_to "quotes" }
    # after_update_commit -> { broadcast_replace_later_to "quotes"}
    # after_destroy_commit -> { broadcast_remove_to "quotes" }
    # the 3 above are the same as the following:
    broadcasts_to ->(quote) { [ quote.company, "quotes" ] }, inserts_by: :prepend

    def total_price
        line_items.sum(&:total_price)
    end
end
