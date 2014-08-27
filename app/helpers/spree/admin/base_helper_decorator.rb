Spree::Admin::BaseHelper.module_eval do
  def preference_field_for(form, field, options)
    if options[:type] == :matrix_id
      form.matrix_field(field, preference_field_options(options))
    else
      super
    end
  end
end
