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

  def field_classes(method)
    classes = "field"
    classes += " inline " if @options.fetch(:inline, false)
    classes += " error " unless object.errors[method].blank?
    classes
  end

  [:text_field, :email_field, :password_field, :number_field, :phone_field, :text_area].each do |field_name|
    define_method field_name do |method, options={}|
      @template.content_tag 'div', class: field_classes(method) do
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
        label(method, options[:label]) + input
      end
    end
  end

  def check_box method, options={}
    @template.content_tag 'div', class: field_classes(method) do
      @template.content_tag 'div', class: "ui toggle checkbox" do
        question = object.respond_to?(:"#{method}?") ? :"#{method}?" : method
        options.merge(value: @object.send(question) ) unless options[:value]
        input = super(question, options)
        input + label(method, options[:label])
      end
    end
  end

  def radio_button method, tag_value, options={}
    @template.content_tag 'div', class: field_classes(method) do
      @template.content_tag 'div', class: "ui radio checkbox" do
        question = object.respond_to?(:"#{method}?") ? :"#{method}?" : method
        options.merge(value: @object.send(question) ) unless options[:value]
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
      label(method, options[:label]) + super(method, collection, value_method, text_method, options, html_options)
    end
  end

  def submit value=nil, options={}
    value, options = nil, value if value.is_a?(Hash)
    color = object.persisted? ? 'blue' : 'green'
    options[:class] ||= "ui #{color} button"
    super value, options
  end
end
