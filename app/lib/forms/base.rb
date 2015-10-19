class Forms::Base < ActionView::Helpers::FormBuilder

  def validation_errors
    if object && object.errors.any?
      @template.content_tag 'div', id: 'error_explanation', class: 'ui visible visible visible visible visible message error' do
        @template.content_tag 'ul', class: 'list' do
          elements = object.errors.full_messages.map do |message|
            @template.content_tag 'li' do
              message
            end
          end
          @template.safe_join elements
        end
      end
    end
  end

  [:text, :email, :password, :number, :phone].each do |type|
    define_method :"#{type}_field" do |method, options={}|
      @template.content_tag 'div', class: "field #{"error" unless object.errors[method].blank?}" do
        options[:placeholder] ||= method.to_s.humanize
        label(options.delete(:label){method}) + super(method, options)
      end
    end
  end

  def collection_select(method, collection, value_method=:id, text_method=:name, options = {}, html_options = {})
    @template.content_tag 'div', class: "field #{"error" unless object.errors[method].blank?}" do
      html_options.merge!(class: "#{html_options[:class]} dropdown")
      label(options.delete(:label){method}) + super(method, collection, value_method, text_method, options, html_options)
    end
  end
end