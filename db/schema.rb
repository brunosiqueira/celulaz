# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110416172335) do

  create_table "addresses", :force => true do |t|
    t.integer  "owner_id",                                      :null => false
    t.string   "owner_type",                                    :null => false
    t.string   "street"
    t.integer  "number"
    t.string   "complement"
    t.string   "zip",          :limit => 10
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state",        :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show",                       :default => true
    t.boolean  "show_sidebar",               :default => false
  end

  add_index "addresses", ["owner_id", "owner_type"], :name => "index_addresses_on_owner_id_and_owner_type"

  create_table "background_tops", :force => true do |t|
    t.integer  "layout_id"
    t.string   "background_top_file_name"
    t.string   "background_top_content_type"
    t.string   "background_top_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "background_tops", ["layout_id"], :name => "fk_background_tops_layout_id"

  create_table "backgrounds", :force => true do |t|
    t.integer  "layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "my_background_file_name"
    t.string   "my_background_content_type"
    t.integer  "my_background_file_size"
    t.datetime "my_background_updated_at"
  end

  add_index "backgrounds", ["layout_id"], :name => "fk_backgrounds_layout_id"

  create_table "banks", :force => true do |t|
    t.integer  "code",       :limit => 3, :null => false
    t.string   "name",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banks", ["code"], :name => "index_banks_on_code", :unique => true

  create_table "banners", :force => true do |t|
    t.integer  "layout_id",                 :null => false
    t.string   "url",                       :null => false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_image_file_name"
    t.string   "banner_image_content_type"
    t.integer  "banner_image_file_size"
    t.datetime "banner_image_updated_at"
  end

  add_index "banners", ["layout_id"], :name => "fk_banners_layout_id"

  create_table "business_companies", :force => true do |t|
    t.integer  "company_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_companies", ["business_id"], :name => "fk_business_companies_business_id"
  add_index "business_companies", ["company_id"], :name => "fk_business_companies_company_id"

  create_table "businesses", :force => true do |t|
    t.integer  "company_id"
    t.integer  "total"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_image_file_name"
    t.string   "business_image_content_type"
    t.integer  "business_image_file_size"
    t.datetime "business_image_updated_at"
  end

  add_index "businesses", ["company_id"], :name => "fk_businesses_company_id"

  create_table "color_templates", :force => true do |t|
    t.string   "name",                       :limit => 6
    t.string   "slogan",                     :limit => 6
    t.string   "title",                      :limit => 6
    t.string   "subtitle",                   :limit => 6
    t.string   "checked_menu",               :limit => 6
    t.string   "unchecked_menu",             :limit => 6
    t.string   "background_menu",            :limit => 6
    t.string   "tool_botton",                :limit => 6
    t.string   "text",                       :limit => 6
    t.string   "tool_body",                  :limit => 6
    t.string   "background",                 :limit => 6
    t.string   "body",                       :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "menu_deselected_text",       :limit => 7
    t.string   "menu_deselected_background", :limit => 7
    t.string   "menu_selected_text",         :limit => 7
    t.string   "menu_selected_background",   :limit => 7
    t.string   "menu_hover_text",            :limit => 7
    t.string   "menu_hover_background",      :limit => 7
    t.string   "title_text",                 :limit => 7
    t.string   "title_background",           :limit => 7
    t.string   "subtitle_text",              :limit => 7
    t.string   "subtitle_background",        :limit => 7
    t.string   "text_background",            :limit => 7
    t.string   "link_text",                  :limit => 7
    t.string   "link_background",            :limit => 7
    t.string   "body_sidebar",               :limit => 7
    t.string   "border",                     :limit => 7
    t.string   "name_company_text",          :limit => 7
    t.string   "slogan_company_text",        :limit => 7
    t.string   "sidebar_text",               :limit => 7
    t.string   "footer_background",          :limit => 7
    t.string   "footer_text",                :limit => 7
  end

  create_table "colors", :force => true do |t|
    t.string   "name",                       :limit => 6
    t.string   "slogan",                     :limit => 6
    t.string   "title",                      :limit => 6
    t.string   "subtitle",                   :limit => 6
    t.string   "checked_menu",               :limit => 6
    t.string   "unchecked_menu",             :limit => 6
    t.string   "background_menu",            :limit => 6
    t.string   "tool_botton",                :limit => 6
    t.string   "text",                       :limit => 6
    t.string   "tool_body",                  :limit => 6
    t.string   "background",                 :limit => 6
    t.string   "body",                       :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout_id"
    t.string   "menu_deselected_text",       :limit => 7
    t.string   "menu_deselected_background", :limit => 7
    t.string   "menu_selected_text",         :limit => 7
    t.string   "menu_selected_background",   :limit => 7
    t.string   "menu_hover_text",            :limit => 7
    t.string   "menu_hover_background",      :limit => 7
    t.string   "title_text",                 :limit => 7
    t.string   "title_background",           :limit => 7
    t.string   "subtitle_text",              :limit => 7
    t.string   "subtitle_background",        :limit => 7
    t.string   "text_background",            :limit => 7
    t.string   "link_text",                  :limit => 7
    t.string   "link_background",            :limit => 7
    t.string   "body_sidebar",               :limit => 7
    t.string   "border",                     :limit => 7
    t.string   "name_company_text",          :limit => 7
    t.string   "slogan_company_text",        :limit => 7
    t.string   "footer_background",          :limit => 7
    t.string   "footer_text",                :limit => 7
    t.string   "sidebar_text",               :limit => 7
  end

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "cnpj",                      :limit => 18
    t.string   "razao_social"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "person_id"
    t.string   "payment_type",              :limit => 10, :default => "mensal"
    t.string   "segment_id"
    t.string   "state_id"
    t.string   "type",                      :limit => 10, :default => "CompanyS", :null => false
    t.boolean  "informal"
    t.string   "drawee_code",               :limit => 15
    t.string   "register_number"
    t.string   "profile_logo_file_name"
    t.string   "profile_logo_content_type"
    t.integer  "profile_logo_file_size"
    t.datetime "profile_logo_updated_at"
  end

  add_index "companies", ["razao_social"], :name => "index_companies_on_razao_social"
  add_index "companies", ["type"], :name => "index_companies_on_type"
  add_index "companies", ["user_id"], :name => "fk_companies_user_id"

  create_table "company_relationships", :force => true do |t|
    t.integer  "company_origin_id",                     :null => false
    t.integer  "company_destiny_id",                    :null => false
    t.boolean  "confirmed",          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_relationships", ["company_destiny_id"], :name => "fk_company_relationships_company_destiny_id"
  add_index "company_relationships", ["company_origin_id"], :name => "fk_company_relationships_company_origin_id"

  create_table "company_services", :force => true do |t|
    t.integer  "company_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_services", ["company_id", "service_id"], :name => "index_company_services_on_company_id_and_service_id", :unique => true
  add_index "company_services", ["service_id"], :name => "fk_company_services_service_id"

  create_table "components", :force => true do |t|
    t.integer  "layout_id"
    t.string   "type"
    t.string   "title",                :limit => 300
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.string   "picture_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "url"
    t.string   "font_colors"
    t.boolean  "show_name",                           :default => true
    t.boolean  "show_email",                          :default => true
    t.boolean  "show_phone",                          :default => true
    t.boolean  "show_address",                        :default => true
    t.boolean  "show_message",                        :default => true
    t.boolean  "show_all_content",                    :default => false
  end

  add_index "components", ["layout_id"], :name => "fk_components_layout_id"

  create_table "constants", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "company_id"
    t.date     "initial_date"
    t.date     "end_date"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "value"
    t.integer  "parcel"
  end

  add_index "contracts", ["company_id"], :name => "fk_contracts_company_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feed_items", :force => true do |t|
    t.string   "item_type"
    t.integer  "item_id"
    t.boolean  "include_comments", :default => false, :null => false
    t.boolean  "is_public",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_likes_count", :default => 0
  end

  add_index "feed_items", ["item_id", "item_type"], :name => "index_feed_items_on_item_id_and_item_type"

  create_table "feed_likes", :force => true do |t|
    t.integer  "company_id"
    t.integer  "feed_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_likes", ["company_id"], :name => "fk_feed_likes_company_id"
  add_index "feed_likes", ["feed_item_id", "company_id"], :name => "index_feed_likes_on_feed_item_id_and_company_id", :unique => true

  create_table "feeds", :force => true do |t|
    t.integer  "company_id"
    t.integer  "feed_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["company_id", "feed_item_id"], :name => "index_feeds_on_company_id_and_feed_item_id"

  create_table "fields", :force => true do |t|
  end

  create_table "folders", :force => true do |t|
    t.integer "user_id"
    t.integer "parent_id"
    t.string  "name"
  end

  create_table "layouts", :force => true do |t|
    t.integer  "company_id"
    t.string   "architecture_type",     :limit => 10
    t.string   "name"
    t.string   "slogan"
    t.string   "website"
    t.text     "presentation_text"
    t.string   "background_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card1_file_name"
    t.string   "card1_content_type"
    t.string   "card1_file_size"
    t.string   "card2_file_name"
    t.string   "card2_content_type"
    t.string   "card2_file_size"
    t.string   "card3_file_name"
    t.string   "card3_content_type"
    t.string   "card3_file_size"
    t.string   "component_decoration"
    t.boolean  "show_name"
    t.boolean  "show_slogan"
    t.boolean  "show_logo"
    t.string   "background_top"
    t.integer  "send_to_friend"
    t.string   "side_image_url"
    t.string   "font_colors"
    t.string   "email"
    t.string   "facebook"
    t.string   "orkut"
    t.string   "twitter"
    t.string   "flickr"
    t.boolean  "repeat_background_x"
    t.boolean  "repeat_background_y"
    t.boolean  "centralize_background"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.string   "analytics"
  end

  add_index "layouts", ["company_id"], :name => "fk_layouts_company_id"

  create_table "message_copies", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answer_id"
    t.boolean  "read"
    t.boolean  "deleted"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "subject",          :limit => 256
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_name",      :limit => 50
    t.string   "sender_email",     :limit => 50
    t.integer  "answer_id"
    t.string   "receiver_email"
    t.boolean  "first_answer"
    t.boolean  "deleted_sent_box"
  end

  add_index "messages", ["receiver_id"], :name => "fk_messages_receiver_id"
  add_index "messages", ["sender_id"], :name => "fk_messages_sender_id"

  create_table "news", :force => true do |t|
    t.integer  "company_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["company_id"], :name => "fk_news_company_id"

  create_table "payments", :force => true do |t|
    t.integer  "company_id"
    t.date     "period_initial_date",                                             :null => false
    t.date     "period_end_date",                                                 :null => false
    t.date     "due_date",                                                        :null => false
    t.string   "payment_type",        :limit => 10,       :default => "mensal",   :null => false
    t.string   "status",              :limit => 10,       :default => "nao_pago", :null => false
    t.text     "description"
    t.string   "content_type"
    t.string   "name_file"
    t.binary   "data",                :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "value"
  end

  add_index "payments", ["company_id"], :name => "fk_payments_company_id"

  create_table "people", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "cpf",             :limit => 14
    t.string   "rg",              :limit => 50
    t.string   "rg_exp",          :limit => 50
    t.date     "rg_exp_date"
    t.date     "date_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subsidiary_id"
    t.string   "user_create_id"
    t.string   "user_confirm_id"
    t.string   "state_id"
    t.string   "user_web_adm_id"
    t.integer  "bank_id"
    t.integer  "agency"
    t.string   "account_number",  :limit => 15
  end

  add_index "people", ["user_id"], :name => "fk_people_user_id"

  create_table "phones", :force => true do |t|
    t.integer  "company_id"
    t.integer  "person_id"
    t.integer  "ddd",        :limit => 3
    t.integer  "number",     :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
  end

  add_index "phones", ["company_id"], :name => "fk_phones_company_id"
  add_index "phones", ["id", "company_id"], :name => "index_phones_on_id_and_company_id", :unique => true
  add_index "phones", ["id", "person_id"], :name => "index_phones_on_id_and_person_id", :unique => true
  add_index "phones", ["person_id"], :name => "fk_phones_person_id"

  create_table "pictures", :force => true do |t|
    t.integer  "component_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "photo_file_size"
    t.string   "photo_content_type"
    t.string   "photo_file_name"
    t.string   "component_type"
  end

  add_index "pictures", ["component_id"], :name => "fk_pictures_component_id"

  create_table "proj_celulaz_test", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "segments", :force => true do |t|
    t.string "name", :limit => 100
    t.string "file", :limit => 30
  end

  add_index "segments", ["name"], :name => "index_segments_on_name", :unique => true

  create_table "services", :force => true do |t|
    t.string   "title",      :limit => 30
    t.string   "image_path", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_titles", :force => true do |t|
    t.integer  "shipping_id"
    t.integer  "title_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipping_titles", ["shipping_id"], :name => "fk_shipping_titles_shipping_id"
  add_index "shipping_titles", ["title_id"], :name => "fk_shipping_titles_title_id"

  create_table "shippings", :force => true do |t|
    t.string   "code"
    t.string   "status",            :limit => 10, :default => "Aberto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "processing_date"
    t.string   "file_name"
    t.string   "file_content_type"
    t.binary   "file_data"
  end

  create_table "states", :force => true do |t|
    t.string   "acronym"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["acronym"], :name => "index_states_on_acronym", :unique => true
  add_index "states", ["name"], :name => "index_states_on_name", :unique => true

  create_table "subsidiaries", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",    :default => true, :null => false
  end

  create_table "subsidiary_states", :force => true do |t|
    t.integer  "subsidiary_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subsidiary_states", ["state_id"], :name => "fk_subsidiary_states_state_id"
  add_index "subsidiary_states", ["subsidiary_id", "state_id"], :name => "index_subsidiary_states_on_subsidiary_id_and_state_id", :unique => true

  create_table "tab_components", :force => true do |t|
    t.integer  "tab_id"
    t.integer  "component_id"
    t.boolean  "full_line"
    t.integer  "line"
    t.integer  "column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tab_components", ["component_id"], :name => "fk_tab_components_component_id"
  add_index "tab_components", ["tab_id", "column", "line"], :name => "index_tab_components_on_tab_id_and_column_and_line", :unique => true
  add_index "tab_components", ["tab_id"], :name => "fk_tab_components_tab_id"

  create_table "tabs", :force => true do |t|
    t.integer  "layout_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "order"
  end

  add_index "tabs", ["layout_id"], :name => "fk_tabs_layout_id"

  create_table "template_texts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", :force => true do |t|
    t.integer  "company_id"
    t.integer  "contract_id"
    t.date     "emission_date"
    t.date     "due_date"
    t.float    "value"
    t.float    "fine_percent"
    t.integer  "days_to_charge_fine",   :limit => 2
    t.float    "interest_percent"
    t.float    "abatement_value"
    t.float    "discount_value"
    t.string   "discount_type"
    t.date     "discount_limit_date"
    t.string   "additional_data",       :limit => 800
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                               :default => "Digitado"
    t.string   "our_number",            :limit => 7
    t.string   "your_number",           :limit => 10
    t.string   "occurrency",            :limit => 2
    t.string   "occurrency_complement", :limit => 2
    t.string   "interest_type",         :limit => 1
    t.string   "error_message"
  end

  add_index "titles", ["company_id"], :name => "fk_titles_company_id"
  add_index "titles", ["contract_id"], :name => "fk_titles_contract_id"
  add_index "titles", ["due_date", "your_number"], :name => "index_titles_on_due_date_and_your_number", :unique => true

  create_table "user_people", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "person_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_people", ["person_id"], :name => "fk_user_people_person_id"
  add_index "user_people", ["user_id"], :name => "fk_user_people_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "enabled",                                 :default => true
    t.string   "type"
    t.boolean  "self_created",                            :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "domain"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "visits", :force => true do |t|
    t.integer  "user_id"
    t.string   "session"
    t.string   "ip_address"
    t.string   "request_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["request_url"], :name => "index_visits_on_request_url"
  add_index "visits", ["session", "request_url"], :name => "index_visits_on_session_and_request_url", :unique => true

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

end
