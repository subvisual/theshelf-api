namespace :web do
  task fetch_covers: :environment do
    website = 'https://www.goodreads.com/search'
    search_form_name = 'searchForm'
    search_input_name = 'q'
    cover_image_selector = '#coverImage'
    agent = Mechanize.new

    within_tmp_dir do
      Book.where(cover: nil).each do |book_without_cover|
        agent.get(website) do |page|
          search_result = page.form(search_form_name) do |search|
            search.send("#{search_input_name}=", book_without_cover.title)
          end.submit

          book_page = agent.click search_result.link_with(text: /#{Regexp.escape(book_without_cover.title)}/)
          image_url = book_page.search(cover_image_selector).first.attributes["src"].value

          File.open("#{book_without_cover.title.parameterize}.png", 'wb') do |file|
            file << open(image_url).read
            book_without_cover.cover = file
          end
          book_without_cover.save
        end
      end
    end
  end

  task update_covers: :environment do
    website = 'https://www.goodreads.com/search'
    search_form_name = 'searchForm'
    search_input_name = 'q'
    cover_image_selector = '#coverImage'
    agent = Mechanize.new

    within_tmp_dir do
      Book.all.each do |book|
        puts "Searching isbn #{book.isbn} ..."
        agent.get(website) do |page|
          search_result = page.form(search_form_name) do |search|
            search.send("#{search_input_name}=", book.isbn)
          end.submit

          cover_images = search_result.search(cover_image_selector)
          if cover_images.any?
            image_url = cover_images.first.attributes["src"].value

            filename = book.isbn.presence || book.title
            File.open("#{filename.parameterize}.png", 'wb') do |file|
              file << open(image_url).read
              book.cover = file
            end
            book.save
          else
            puts "Isbn #{book.isbn} not found. Moving to the next book"
          end
        end
      end
    end
  end
end

def within_tmp_dir
  Dir.mkdir('covers_tmp') unless Dir.exists?('covers_tmp')
  Dir.chdir('covers_tmp') do
    yield
  end
  FileUtils.rm_rf('covers_tmp')
end
