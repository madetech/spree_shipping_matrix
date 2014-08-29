Spree::Admin::BaseHelper.module_eval do
  alias_method :original_preference_field_for, :preference_field_for

  def preference_field_for(form, field, options)
    if options[:type] == :matrix_id
      form.matrix_field(field, preference_field_options(options))
    else
      original_preference_field_for(form, field, options)
    end
  end
end
