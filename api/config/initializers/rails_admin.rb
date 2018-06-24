RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Person do
    object_label_method do
      :custom_person_label
    end

    show do
      configure :tbrc_link
      field :tbrc_link do
       formatted_value do
         bindings[:view].tag(:a, { :href => bindings[:object].tbrc_link, :target => '_blank' }) << value
       end
      end
      fields :tbrc_rid, :default_name, :wylie_name, :wylie_name_script, :birth_year, :death_year, :birth_approx, :death_approx, :lived, :gender, 
        :har_url, :landmark_id, :geography_id, :community_id, :historical_period_id, :tradition_id, :birth_century_id, :death_century_id, :birth_estimated, :death_estimated,
        :default_title, :wylie_title, :published_default_name, :published_wylie_name, :url_default_name, :url_wylie_name, :person_type
    end
  end

  Person.class_eval do
    def custom_person_label
      wylie_name
    end
  end
end
