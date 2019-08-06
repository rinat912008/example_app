module Api
  class PaginationPage < Tram::Page
    param :total
    param :host
    option :config, default: -> { Rails.configuration.application['pagination'] }
    option :page_number, type: proc(&:to_i), default: -> { config['page_number'] }
    option :page_size, type: proc(&:to_i), default: -> { config['page_size'] }

    section :self_page, value: -> { page_url(page_number) }
    section :first_page, value: -> { page_url(config['page_number']) }
    section :prev_page, value: -> { page_url(prev_page_number) }
    section :next_page, value: -> { page_url(next_page_number) }
    section :last_page, value: -> { page_url(last_page_number) }
    section :total_pages, value: -> { last_page_number }
    section :current_page, value: -> { page_number }

    private

    def page_url(page_number)
      "#{url}?page[number]=#{page_number}&page[size]=#{page_size}"
    end

    def url
      uri = URI(host)
      "#{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}"
    end

    def prev_page_number
      page_number == config['page_number'] ? page_number : page_number - 1
    end

    def last_page_number
      (total.to_f / page_size).ceil
    end

    def next_page_number
      page_number == last_page_number ? page_number : page_number + 1
    end
  end
end
