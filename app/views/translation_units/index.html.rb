# encoding: utf-8

require Rails.root.join('app', 'views', 'layouts', 'application.html.rb')

module Views
  module TranslationUnits
    class Index <Views::Layouts::Application
      protected

      def body_content
        article(class: 'container') do
          ul(class: 'nav nav-tabs') do
            li { a "Translations", href: search_translations_url }
            li { a "Keys", href: search_keys_url }
            li(class: 'active') { a "Translation Memory", href: translation_units_url }
          end
          div(class: 'tab-content') do
            filter_bar
            translation_grid
          end
        end
      end

      def active_tab() 'search' end

      private

      def filter_bar
        form_tag(translation_units_url, method: :get, id: 'translation-units-search-form', class: 'filter form-inline') do
          text 'Find '
          text_field_tag 'keyword', '', id: 'search-field', placeholder: 'keyword'
          text ' in '
          select_tag 'field', options_for_select([
                                                     %w(source searchable_source_copy),
                                                     %w(translation searchable_copy),
                                                 ]), id: 'field-select', class: 'span2'
          text ' with translation in '
          if current_user.approved_locales.any?
            select_tag 'target_locales', options_for_select(current_user.approved_locales.map { |l| [l.name, l.rfc5646] })
          else
            text_field_tag 'target_locales', '', class: 'locale-field locale-field-list span2', id: 'locale-field', placeholder: "any target locale"
          end
          text ' '
          submit_tag "Search", class: 'btn btn-primary'
        end
      end

      def translation_grid
        table(class: 'table table-striped table-hover', id: 'translation_units', 'data-url' => translation_units_url(format: 'json'))
      end
    end
  end
end
