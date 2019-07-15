class Book < ApplicationRecord
  default_scope { order(:created_at)}
  belongs_to :category
  validates :title,
            :subtitle,
            :authors,
            :description,
            :published_date,
            :page_count,
            :thumbnail,
            :isbn,
            presence: true

  def self.processed_set
    Book.all.map do |book|
      book.processed_data
    end
  end

  def processed_data
    {
      id: id,
      title: title,
      subtitle: subtitle,
      category: category.name,
      description: description,
      authors: authors,
      thumbnail: thumbnail,
      isbn: isbn,
      page_count: page_count
    }
  end

end
