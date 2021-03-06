class Book < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_term, against: %i[
    title
    subtitle
    authors
    description
    category
    isbn
  ],
                                   using: {
                                     tsearch: {
                                       any_word: true,
                                       prefix: true
                                     }
                                   }

  pg_search_scope :search_by_category, against: %i[category],
                                       using: {
                                         tsearch: {
                                           any_word: true,
                                           prefix: true
                                         }
                                       }

  default_scope { order(:created_at).eager_load(:items) }
  validates :title,
            :subtitle,
            :authors,
            :description,
            :category,
            :published_date,
            :page_count,
            :thumbnail,
            :isbn,
            presence: true

  validates :isbn, uniqueness: true

  has_many :items,
           class_name: 'CollectionItem', foreign_key: :book_id,
           dependent: :destroy

  def self.paginated(page, user)
    offset = (page.to_i - 1) * 10
    Book.limit(10).offset(offset).map do |book|
      book.data_hash_for_user(user)
    end
  end

  def data_hash
    {
      book_id: id,
      title: title,
      subtitle: subtitle,
      authors: authors,
      category: category,
      description: description,
      published_date: published_date,
      isbn: isbn,
      page_count: page_count,
      thumbnail: thumbnail
    }
  end

  def data_hash_for_user(user)
    book_ids = user.collection.map { |item| item[:book_id] }
    included = book_ids.include?(id)
    item_id = included ? user.items.where('book_id=?', id).first.id : nil
    data_hash.merge(included: included, item_id: item_id)
  end

  def self.user_book_search(user, keyword, page)
    initial_set = Book.search_by_term(keyword)
    initial_index = page.to_i - 1
    initial_set.map do |book|
      included = !user.items.where("book_id=?", book.id).empty?
      item_id = included ? user.items.where("book_id=?", book.id).first.id : nil
      book.data_hash.merge(included: included, item_id: item_id)
    end.slice(initial_index * 10, 10)
  end
end
