module Api
  class BasePage < Tram::Page
    option :config, default: -> { Rails.configuration.application['pagination'] }
    option :pagination, optional: true, default: -> { {} }

    section :meta

    def meta
      return unless pagination?

      Api::Merchants::V1::PaginationPage.new(relation.count,
                                             pagination[:url],
                                             page_number: page_number,
                                             page_size: page_size).to_h
    end

    private

    def pagination?
      pagination[:page_number] && pagination[:page_size] && pagination[:url]
    end

    def page_number
      @page_number ||= pagination[:page_number].zero? ? config['page_number'] : pagination[:page_number]
    end

    def page_size
      @page_size ||= pagination[:page_size].zero? ? config['page_size'] : pagination[:page_size]
    end
  end
end
