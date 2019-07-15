json.book do
  json.call(
    @book,
    :title,
      :subtitle,
      :authors,
      :description,
      :published_date,
      :thumbnail,
      :isbn,
      :page_count,
      :category
  )
end