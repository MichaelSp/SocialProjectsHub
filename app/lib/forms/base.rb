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

  [:text_field, :email_field, :password_field, :number_field, :phone_field, :text_area].each do |field_name|
    define_method field_name do |method, options={}|
      classes = "field"
      classes += " inline " if @options.fetch(:inline, false)
      classes += " error " unless object.errors[method].blank?
      @template.content_tag 'div', class: classes do
        options[:placeholder] ||= method.to_s.humanize
        input = if options.fetch(:labeled, false)
                  @template.content_tag 'div', class: 'ui labeled input' do
                    tags = @template.content_tag 'div', class: 'ui label' do
                      options.delete :labeled
                    end
                    tags + super(method, options)
                  end
                else
                  super(method, options)
                end
        label(options.delete(:label) { method }) + input
      end
    end
  end

  def radio_button method, tag_value, options={}
    @template.content_tag 'div', class: "field" do
      @template.content_tag 'div', class: "ui radio checkbox" do
        question = object.respond_to?(:"#{method}?") ? :"#{method}?" : method
        options.merge(value: @object.send(question) ) unless option[:value]
        input = super(question, tag_value, options)
        label(options.delete(:label) { tag_value }) + input
      end
    end
  end

  def search_field method, options={}
    @template.content_tag 'div', class: 'field' do
      @template.content_tag 'div', class: %w{ui left icon input} do
        options[:placeholder] ||= 'Search'
        @template.safe_join [
                                @template.content_tag('i', '', class: "search icon"),
                                super(method, options)
                            ]
      end
    end
  end

  def collection_select(method, collection, value_method=:id, text_method=:name, options = {}, html_options = {})
    classes = options.delete(:field_class){'field '}
    classes += " error" if object && !object.errors[method].blank?
    @template.content_tag 'div', class: classes do
      html_options.merge!(class: "#{html_options[:class]} dropdown")
      label(options.delete(:label) { method }) + super(method, collection, value_method, text_method, options, html_options)
    end
  end

  def submit options={}
    options[:class] ||= 'ui button'
    super options
  end
end