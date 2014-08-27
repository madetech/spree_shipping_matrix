ActionView::Helpers::FormBuilder.class_eval do
  def matrix_field(method, options)
    collection_select(method,
                      Spree::ShippingMatrix.all,
                      :id, :name,
                      options,
                      class: 'select2 fullwidth')
  end
end
