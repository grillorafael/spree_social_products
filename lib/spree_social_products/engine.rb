module SpreeSocialProducts
  class Engine < Rails::Engine
    engine_name 'spree_social_products'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer "spree.spree_social_products.preferences", :before => :load_config_initializers do |app|
      Spree::AppConfiguration.class_eval do
        # Social Sharing Preferences
        preference :twitter_button, :boolean, :default => true
        preference :gplus_button, :boolean, :default => true
        preference :tumblr_button, :boolean, :default => false
        preference :pinterest_button, :boolean, :default => false
        preference :facebook_button, :boolean, :default => true
        preference :delicious_button, :boolean, :default => false
        preference :reddit_button, :boolean, :default => false
      
        preference :facebook_app_id, :string
        preference :facebook_layout, :string, :default => 'standard'
        preference :facebook_show_faces, :boolean, :default => false
        preference :facebook_verb_to_display, :string, :default => 'like'
        preference :facebook_color_scheme, :string, :default => 'light'
        preference :facebook_send_button, :boolean, :default => false
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
