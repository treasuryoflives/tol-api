# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_31_133854) do

  create_table "about_page", primary_key: "about_page_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "about_heading"
    t.string "main_image", limit: 2048
    t.string "number_1", limit: 2048
    t.text "number_1_text"
    t.string "number_2", limit: 2048
    t.text "number_2_text"
    t.string "number_3", limit: 2048
    t.text "number_3_text"
    t.text "description"
    t.text "bio_1"
    t.string "bio_1_image", limit: 2048
    t.text "bio_2"
    t.string "bio_2_image", limit: 2048
    t.string "bio_3", limit: 2048
    t.string "bio_3_image", limit: 2048
    t.text "bio_4"
    t.string "bio_4_image", limit: 2048
    t.text "editorial_committee"
    t.text "advisory_committee"
    t.string "partner_image_1", limit: 100
    t.string "partner_link_1", limit: 1000
    t.string "partner_image_2", limit: 100
    t.string "partner_link_2", limit: 1000
    t.string "partner_image_3", limit: 100
    t.string "partner_link_3", limit: 1000
    t.text "authors_contact"
    t.text "donate_text"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "alt_parent", primary_key: "alt_parent_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "parent_community_id", null: false
    t.integer "priority", null: false
    t.index ["community_id", "parent_community_id"], name: "alt_parent-community_id-parent_community_id"
  end

  create_table "author", primary_key: "author_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "author_name", limit: 100, null: false
    t.string "first_name", limit: 60
    t.string "last_name", limit: 60
    t.string "clean_name", limit: 120
    t.text "bio_text"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id", null: false
    t.string "last_modified_date", limit: 60, null: false
    t.integer "user_id"
    t.index ["author_id"], name: "author_id_UNIQUE", unique: true
    t.index ["create_user_id"], name: "fk_author_create_user_id"
    t.index ["last_modified_user_id"], name: "fk_author_last_modified_user_id"
    t.index ["last_name", "first_name", "author_id"], name: "ix_author_list"
    t.index ["user_id", "author_id"], name: "ix_author_user_check"
    t.index ["user_id"], name: "fk_author_user_id"
  end

  create_table "author_bio_xref", primary_key: ["author_id", "biography_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "author_id", null: false, unsigned: true
    t.integer "biography_id", null: false
    t.index ["author_id"], name: "fk_author_bio_xref_author_id"
    t.index ["biography_id"], name: "fk_author_bio_xref_biography_id"
  end

  create_table "auto_modal", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.text "html", null: false
    t.boolean "enabled", default: true, null: false
  end

  create_table "bibliography", primary_key: "bibliography_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "author"
    t.string "title", limit: 1000
    t.string "date"
    t.string "page"
    t.text "full_entry"
    t.string "published", limit: 3
  end

  create_table "bio_crosslink", primary_key: ["source_bio_id", "link_bio_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "source_bio_id", null: false
    t.integer "link_bio_id", null: false
    t.integer "person_id", null: false
    t.string "default_name", limit: 100, null: false
    t.string "tbrc_rid", limit: 25, null: false
    t.index ["link_bio_id"], name: "fk_bio_crosslink_link_bio_id"
    t.index ["person_id"], name: "fk_bio_crosslink_person_id"
    t.index ["source_bio_id"], name: "fk_bio_crosslink_source_bio_id"
  end

  create_table "bio_crosslink_draft", primary_key: ["source_bio_id", "link_bio_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "source_bio_id", null: false
    t.integer "link_bio_id", null: false
    t.integer "person_id", null: false
    t.string "default_name", limit: 100, null: false
    t.string "tbrc_rid", limit: 25, null: false
    t.index ["link_bio_id"], name: "fk_bio_crosslink_draft_link_bio_id"
    t.index ["person_id"], name: "fk_bio_crosslink_draft_person_id"
    t.index ["source_bio_id"], name: "fk_bio_crosslink__draft_source_bio_id"
  end

  create_table "bio_draft", primary_key: "biography_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "bio_draft_text", null: false
    t.datetime "last_modified_date", null: false
    t.integer "last_modified_user_id", null: false
    t.index ["biography_id"], name: "fk_bio_draft_biography_id"
    t.index ["last_modified_user_id"], name: "fk_bio_draft_last_modified_user_id"
  end

  create_table "biography", primary_key: "biography_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "summary", limit: 2048
    t.text "body_text"
    t.text "sources"
    t.string "tags", limit: 1024
    t.integer "publish_type_id", default: 1, null: false
    t.boolean "is_indexed", default: false, null: false
    t.boolean "is_locked", default: false, null: false, unsigned: true
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date", null: false
    t.boolean "is_deleted", default: false, null: false, unsigned: true
    t.integer "views", default: 0, null: false, unsigned: true
    t.datetime "initial_approval_date"
    t.boolean "peer_reviewed", default: false, null: false
    t.string "published_display_date", limit: 1000
    t.string "updated_display_date", limit: 1000
    t.string "published_default_name"
    t.index ["create_user_id"], name: "fk_biography_create_user_id"
    t.index ["initial_approval_date", "is_deleted", "biography_id", "person_id"], name: "ix_biography_approval"
    t.index ["last_modified_user_id"], name: "fk_biography_last_modified_user_id"
    t.index ["lock_user_id"], name: "fk_biography_lock_user_id"
    t.index ["person_id"], name: "fk_biography_person_id"
    t.index ["publish_type_id"], name: "fk_biography_publish_type_id"
  end

  create_table "biography_fulltext", primary_key: "biography_fulltext_id", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "biography_id"
    t.integer "person_id", null: false
    t.string "default_name", limit: 100, null: false
    t.string "wylie_name", limit: 100
    t.string "summary", limit: 2048
    t.text "body_text"
    t.datetime "initial_approval_date"
    t.text "sources"
    t.string "tags", limit: 1024
    t.text "name_variants"
    t.datetime "refresh_date", null: false
    t.string "tbrc_rid", limit: 25
    t.string "published_default_name"
    t.string "published_wylie_name"
    t.boolean "peer_reviewed", default: false, null: false
    t.string "published_display_date", limit: 1000
    t.string "updated_display_date", limit: 1000
    t.index ["default_name", "wylie_name", "published_default_name", "published_wylie_name"], name: "idx_person_name_fulltext", type: :fulltext
    t.index ["default_name", "wylie_name", "summary", "body_text", "tags", "name_variants", "tbrc_rid", "published_default_name", "published_wylie_name"], name: "idx_biography_fulltext", type: :fulltext
    t.index ["person_id", "biography_id"], name: "idx_biography_fulltext_person_id"
  end

  create_table "biography_sponsor_xref", primary_key: ["biography_id", "sponsor_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "biography_id", null: false
    t.integer "sponsor_id", null: false
  end

  create_table "century", primary_key: "century_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cms_label", limit: 45, null: false
    t.string "public_label", limit: 20, null: false
    t.integer "default_year", null: false
    t.index ["century_id", "cms_label", "default_year"], name: "idx_century_cms_lookup"
    t.index ["century_id", "public_label"], name: "idx_century_public_lookup"
  end

  create_table "comment", primary_key: "comment_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "parent_comment_id", unsigned: true
    t.integer "create_user_id"
    t.string "nickname", limit: 30, null: false
    t.string "email_addr", limit: 75
    t.boolean "reply_notify", default: false, null: false
    t.boolean "is_new_reply", default: false
    t.integer "biography_id", null: false
    t.boolean "is_approved", default: false, null: false
    t.integer "approve_user_id"
    t.datetime "approve_date"
    t.datetime "create_date", null: false
    t.text "comment_text", null: false
    t.index ["approve_user_id"], name: "fk_comment_approve_user_id"
    t.index ["biography_id", "parent_comment_id", "comment_id"], name: "idx_comment_hierarchy"
    t.index ["create_user_id"], name: "fk_comment_create_user_id"
    t.index ["parent_comment_id"], name: "fk_comment_parent_comment_id"
  end

  create_table "community", primary_key: "community_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "community_name", limit: 50, null: false
    t.string "facet_link"
    t.string "wylie_name", limit: 50
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "name_variants", limit: 1000
    t.string "image_file_name", limit: 50
    t.string "image_credit", limit: 1000
    t.string "image_source_url", limit: 1000
    t.string "image_path", limit: 1000
    t.text "description"
    t.text "sources"
    t.string "founded_date", limit: 100
    t.string "founded_century", limit: 4
    t.string "existed_by_century", limit: 4
    t.string "blurb", limit: 1024
    t.string "tbrc_id", limit: 45
    t.string "branch_of"
    t.string "tradition", limit: 1000
    t.string "tbrc_cid", limit: 100
    t.string "region"
    t.string "sub_region"
    t.string "local_region"
    t.string "lat", limit: 45
    t.string "long", limit: 45
    t.string "google_lat", limit: 100
    t.string "google_long", limit: 100
    t.string "updated", limit: 3
    t.text "xml", limit: 4294967295
    t.string "founder_tbrc_rid", limit: 100
    t.integer "families_traditions_flag"
    t.string "hide_timeline", limit: 100
    t.string "timeline_start_date", limit: 100
    t.string "timeline_end_date", limit: 100
    t.string "tol_id", limit: 100
    t.string "cluster", limit: 2
    t.integer "min_zoom"
    t.datetime "last_modified_date"
    t.datetime "create_date"
    t.string "icon", limit: 8
    t.string "place_category", limit: 3
    t.index ["community_name"], name: "community-community_name"
    t.index ["place_category"], name: "community-place_category"
  end

  create_table "community_bio_xref", primary_key: "community_bio_xref_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "x_biography_id", null: false
    t.integer "priority", null: false
  end

  create_table "community_facet", primary_key: "community_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "community_hierarchy_id", null: false
    t.integer "person_id"
    t.index ["community_hierarchy_id"], name: "fk_community_facet_community_hierarchy_id"
  end

  create_table "community_geography_xref", primary_key: "community_geography_xref_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "geography_id", null: false
    t.integer "priority"
  end

  create_table "community_hierarchy", primary_key: "community_hierarchy_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "community_id", null: false
    t.integer "parent_community_id"
    t.integer "ordinal"
    t.index ["community_id"], name: "fk_community_hierarchy_community_id"
    t.index ["parent_community_id"], name: "fk_community_hierarchy_parent_community_id"
  end

  create_table "contribution", primary_key: "contribution_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "contributor_user_id", null: false
    t.integer "editor1_user_id"
    t.integer "editor2_user_id"
    t.string "contributor_name", limit: 100, null: false
    t.string "lama_default_name", limit: 100, null: false
    t.string "lama_wylie_name", limit: 100, null: false
    t.string "tbrc_rid", limit: 25
    t.integer "person_id"
    t.integer "current_status_id", default: 1, null: false, unsigned: true
    t.string "current_document"
    t.timestamp "create_stamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "last_modified_stamp"
    t.boolean "is_deleted", default: false, null: false
    t.integer "biography_id"
    t.index ["biography_id"], name: "fk_contribution_biography_id"
    t.index ["contribution_id"], name: "contribution_id_UNIQUE", unique: true
    t.index ["contributor_user_id", "current_status_id", "is_deleted"], name: "ix_contribution_by_author"
    t.index ["contributor_user_id"], name: "fk_contribution_contributor_user_id"
    t.index ["current_status_id", "is_deleted"], name: "ix_contribution_by_status"
    t.index ["current_status_id"], name: "fk_contribution_current_status_id"
    t.index ["editor1_user_id", "editor2_user_id", "current_status_id", "contributor_user_id"], name: "ix_contribution_by_editor"
    t.index ["editor1_user_id"], name: "fk_contribution_editor1_user_id"
    t.index ["editor2_user_id"], name: "fk_contribution_editor2_user_id"
    t.index ["person_id"], name: "fk_contribution_person_id"
  end

  create_table "contribution_status", primary_key: "contribution_status_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "status_name", limit: 45, null: false
    t.index ["contribution_status_id"], name: "contribution_status_id_UNIQUE", unique: true
  end

  create_table "contribution_step", primary_key: "contribution_step_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "contribution_id", null: false, unsigned: true
    t.integer "revision_id", null: false, unsigned: true
    t.text "comment"
    t.integer "contribution_status_id", null: false, unsigned: true
    t.integer "create_user_id", null: false
    t.integer "target_user_id"
    t.boolean "was_viewed", default: false, null: false
    t.timestamp "create_stamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["contribution_id"], name: "fk_contribution_step_contribution_id"
    t.index ["contribution_status_id", "contribution_id", "create_stamp"], name: "ix_contribution_step_by_status"
    t.index ["contribution_status_id"], name: "fk_contribution_step_contribution_status_id"
    t.index ["contribution_step_id"], name: "contribution_step_id_UNIQUE", unique: true
    t.index ["create_user_id"], name: "fk_contribution_step_create_user_id"
    t.index ["revision_id"], name: "fk_contribution_step_revision_id"
    t.index ["target_user_id", "create_stamp", "contribution_id", "contribution_status_id", "revision_id", "contribution_step_id", "was_viewed"], name: "ix_contribution_step_by_target"
    t.index ["target_user_id"], name: "fk_contribution_step_target_user_id"
  end

  create_table "encoding_type", primary_key: "encoding_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "encoding_type_key", limit: 25, null: false
    t.string "encoding_type_caption", limit: 50, null: false
  end

  create_table "essay", primary_key: "essay_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "tradition_id"
    t.integer "essay_category_id"
    t.string "essay_title", limit: 100, null: false
    t.string "summary", limit: 2048, null: false
    t.text "body_text", null: false
    t.string "tags", limit: 1024
    t.integer "publish_type_id", default: 1, null: false
    t.boolean "is_indexed", default: false, null: false
    t.boolean "is_locked", default: false, null: false, unsigned: true
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date", null: false
    t.boolean "is_deleted", default: false, null: false, unsigned: true
    t.integer "views", default: 0, null: false, unsigned: true
    t.index ["essay_category_id"], name: "fk_essay_essay_category_id"
    t.index ["lock_user_id"], name: "fk_essay_lock_user_id"
    t.index ["publish_type_id"], name: "fk_essay_publish_type_id"
    t.index ["tradition_id"], name: "fk_essay_tradition_id"
  end

  create_table "essay_category", primary_key: "essay_category_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name", limit: 75, null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "essay_fulltext", primary_key: "essay_fulltext_id", id: :integer, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "essay_id", null: false
    t.integer "tradition_id"
    t.integer "essay_category_id"
    t.string "essay_title", limit: 100, null: false
    t.string "summary", limit: 2048, null: false
    t.text "body_text", null: false
    t.string "tags", limit: 1024
    t.datetime "refresh_date", null: false
    t.index ["essay_title", "summary", "body_text", "tags"], name: "idx_essay_fulltext", type: :fulltext
  end

  create_table "essay_image", primary_key: "essay_image_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "essay_id", null: false
    t.string "image_file_name", limit: 50, null: false
    t.string "thumb_file_name", limit: 60, null: false
    t.string "har_number", limit: 15
    t.string "image_credit", limit: 50
    t.integer "is_primary", default: 0, null: false, unsigned: true
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id"
    t.datetime "last_modified_date"
    t.index ["create_user_id"], name: "FK_essay_image_create_user_id"
    t.index ["essay_id", "image_file_name", "thumb_file_name", "is_primary"], name: "IX_essay_image_person_id"
    t.index ["last_modified_user_id"], name: "FK_essay_image_last_modified_user_id"
  end

  create_table "essay_tradition_facet", primary_key: "essay_tradition_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tradition_hierarchy_id", null: false
    t.integer "essay_id"
    t.index ["tradition_hierarchy_id"], name: "fk_essay_tradition_facet_tradition_hierarchy_id"
  end

  create_table "exhibition", primary_key: "exhibition_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.boolean "is_deleted", default: false, null: false
    t.integer "create_user_id", null: false
    t.datetime "create_date"
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date"
    t.integer "publish_type_id", default: 1, null: false
    t.boolean "is_locked", default: false, null: false
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.index ["create_user_id"], name: "fk_exhibition_create_user_id"
    t.index ["exhibition_id"], name: "exhibition_id_UNIQUE", unique: true
    t.index ["is_deleted", "exhibition_id", "title"], name: "ix_exhibition_list"
    t.index ["last_modified_user_id"], name: "fk_exhibition_last_modified_user_id"
    t.index ["lock_user_id"], name: "fk_exhibition_lock_user_id"
    t.index ["publish_type_id"], name: "fk_exhibition_publish_type_id"
  end

  create_table "exhibition_painting_xref", primary_key: ["exhibition_id", "painting_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "exhibition_id", null: false, unsigned: true
    t.integer "painting_id", null: false, unsigned: true
    t.index ["exhibition_id"], name: "fk_exhibition_painting_xref_exhibition_id"
    t.index ["painting_id"], name: "fk_exhibition_painting_xref_painting_id"
  end

  create_table "geography", primary_key: "geography_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "geography_name", limit: 50, null: false
    t.string "wylie_name", limit: 50
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "image_file_name", limit: 50
    t.text "description"
    t.string "blurb", limit: 1024
    t.string "lat", limit: 45
    t.string "long", limit: 45
    t.string "tbrc_id", limit: 45
  end

  create_table "geography_facet", primary_key: "geography_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "geography_hierarchy_id", null: false
    t.integer "person_id"
    t.index ["geography_hierarchy_id"], name: "fk_geography_facet_geography_hierarchy_id"
  end

  create_table "geography_hierarchy", primary_key: "geography_hierarchy_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "geography_id", null: false
    t.integer "parent_geography_id"
    t.integer "ordinal"
    t.index ["geography_id"], name: "fk_geography_hierarchy_geography_id"
    t.index ["parent_geography_id"], name: "fk_geography_hierarchy_parent_geography_id"
  end

  create_table "geography_map_region_xref", primary_key: "geography_map_region_xref_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "geography_id"
    t.integer "map_region_id"
    t.integer "priority"
  end

  create_table "historical_period", primary_key: "historical_period_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "historical_period_name", limit: 50, null: false
    t.string "wylie_name", limit: 50
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "image_file_name", limit: 50
    t.text "description"
    t.string "blurb", limit: 1024
  end

  create_table "historical_period_facet", primary_key: "historical_period_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "historical_period_hierarchy_id", null: false
    t.integer "person_id"
    t.index ["historical_period_hierarchy_id"], name: "fk_historical_period_facet_historical_period_hierarchy_id"
  end

  create_table "historical_period_hierarchy", primary_key: "historical_period_hierarchy_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "historical_period_id", null: false
    t.integer "parent_historical_period_id"
    t.integer "ordinal"
    t.index ["historical_period_id"], name: "fk_historical_period_hierarchy_historical_period_id"
    t.index ["parent_historical_period_id"], name: "fk_historical_period_hierarchy_parent_historical_period_id"
  end

  create_table "incarnation", primary_key: "incarnation_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "root_person_id", null: false
    t.integer "leaf_person_id", null: false
    t.index ["leaf_person_id"], name: "fk_incarnation_leaf_person_id"
    t.index ["root_person_id", "leaf_person_id"], name: "ix_incarnation_lookup"
  end

  create_table "incarnation_lineages", primary_key: "incarnation_lineages_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tbrc_rid", limit: 1000
    t.string "tradition", limit: 1000, null: false
    t.string "incarnation_name", limit: 1000, null: false
    t.string "wylie_name", limit: 1000
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "name_variants", limit: 1000
    t.string "image_file_name", limit: 1000
    t.string "tbrc_gid", limit: 1000
    t.string "tbrc_cid", limit: 1000
    t.string "tbrc_pid", limit: 1000
    t.text "description"
    t.text "tol_notes"
    t.text "tbrc_notes"
    t.text "tbrc_review"
    t.string "person_id", limit: 11
    t.string "additional_person_list", limit: 1000
    t.index ["incarnation_lineages_id"], name: "incarnation_lineages_id", unique: true
  end

  create_table "kinship", primary_key: "kinship_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "father_person_id"
    t.integer "mother_person_id"
    t.index ["father_person_id"], name: "fk_kinship_father_person_id"
    t.index ["mother_person_id"], name: "fk_kinship_mother_person_id"
    t.index ["person_id"], name: "ix_kinship_person_id"
  end

  create_table "landmark", primary_key: "landmark_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "landmark_name", limit: 50, null: false
    t.string "wylie_name", limit: 50
    t.string "image_file_name", limit: 50
    t.text "description"
    t.string "blurb", limit: 1024
  end

  create_table "landmark_facet", primary_key: "landmark_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "landmark_hierarchy_id", null: false
    t.integer "person_id"
    t.index ["landmark_hierarchy_id"], name: "fk_landmark_facet_landmark_hierarchy_id"
  end

  create_table "landmark_hierarchy", primary_key: "landmark_hierarchy_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "landmark_id", null: false
    t.integer "parent_landmark_id"
    t.integer "ordinal"
    t.index ["landmark_id"], name: "fk_landmark_hierarchy_landmark_id"
    t.index ["parent_landmark_id"], name: "fk_landmark_hierarchy_parent_landmark_id"
  end

  create_table "language_type", primary_key: "language_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "language_type_key", limit: 25, null: false
    t.string "language_type_caption", limit: 50, null: false
  end

  create_table "lineage", primary_key: "lineage_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "teacher_person_id", null: false
    t.integer "student_person_id", null: false
    t.index ["student_person_id"], name: "fk_lineage_student_person_id"
    t.index ["teacher_person_id"], name: "fk_lineage_teacher_person_id"
  end

  create_table "localization", primary_key: "localization_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "language"
    t.string "language_localized"
    t.string "language_code"
    t.string "a_biographical_encyclopedia", limit: 1000
    t.string "about"
    t.string "authors"
    t.string "browse_most_recent", limit: 45
    t.string "barom", limit: 45
    t.string "bibliography", limit: 45
    t.string "bios"
    t.string "biographies", limit: 45
    t.string "bodong", limit: 45
    t.string "bon", limit: 45
    t.string "clan", limit: 45
    t.string "clear_search", limit: 45
    t.string "community", limit: 45
    t.string "contact"
    t.string "copyright", limit: 1000
    t.string "drigung", limit: 45
    t.string "drukpa", limit: 45
    t.string "enter_your_email", limit: 45
    t.string "families_officials"
    t.string "geluk", limit: 45
    t.string "geography", limit: 45
    t.string "goverment_officials", limit: 45
    t.string "historical_period", limit: 45
    t.string "incarnations", limit: 45
    t.string "institution", limit: 45
    t.string "jonang", limit: 45
    t.string "kadam", limit: 45
    t.string "kalachakra", limit: 45
    t.string "karma", limit: 45
    t.string "lamdre", limit: 45
    t.string "lhasa_aristocracy", limit: 45
    t.string "log_in", limit: 45
    t.string "log_out"
    t.string "marpa_kagyu", limit: 45
    t.string "martsang", limit: 45
    t.string "most_recent_biographies", limit: 45
    t.string "name_variants", limit: 45
    t.string "ngok_lineage", limit: 45
    t.string "nyingma", limit: 45
    t.string "office"
    t.string "offices_held"
    t.string "orgyen_nyendrub", limit: 45
    t.string "paintings", limit: 45
    t.string "pakdru", limit: 45
    t.string "place"
    t.string "previous_incarnations", limit: 45
    t.string "prominent_families"
    t.string "published", limit: 45
    t.string "raluk", limit: 45
    t.string "rechung_nyengyu", limit: 45
    t.string "religious_traditions"
    t.string "royalty", limit: 45
    t.string "sakya", limit: 45
    t.string "search", limit: 45
    t.string "search_the_map", limit: 45
    t.string "shangpa_kagyu", limit: 45
    t.string "shukseb", limit: 45
    t.string "students", limit: 45
    t.string "submissions"
    t.string "subscribe", limit: 45
    t.string "subscribe_to_our_newsletter", limit: 45
    t.string "subsequent_incarnations", limit: 45
    t.string "taklung", limit: 45
    t.string "teachers", limit: 45
    t.string "timeline", limit: 45
    t.string "tradition"
    t.string "traditions"
    t.string "treasury_of_lives", limit: 45
    t.string "tropu", limit: 45
    t.string "tselpa", limit: 45
    t.string "view_map"
    t.string "view_bios"
    t.string "yabzang", limit: 45
    t.string "yelpa_kagyu", limit: 45
    t.string "zhije_and_chod", limit: 45
    t.string "CONTACT_US"
    t.string "THERE_ARE_X_RELATED_BIOGRAPHIES"
    t.string "VIEW_THIS_PERSONS_ASSOCIATED_WORKS_AND_TEXTS_ON_THE_TIBETAN"
    t.string "THE_TREASURY_OF_LIVES_WELCOMES_SUGGESTIONS_FROM_OUR_COMMUNITY"
    t.string "PLEASE_USE_THE_FORM_BELOW_TO_CONTACT_US_WITH_YOUR_FEEDBACK"
    t.string "MESSAGE"
    t.string "CREATE_AN_ACCOUNT"
    t.string "Copyright_Shelley_and_Donald_Rubin_Foundation_Content"
    t.string "REFINE_YOUR_SEARCH"
    t.string "ADD_SEARCH_TERM"
    t.string "REFINE_SEARCH"
    t.string "SEND"
    t.string "PEER_REVIEWED"
    t.string "CITE_THIS_BIOGRAPHY"
    t.string "SUBMIT"
    t.string "Select_a_place_to_view_details_and_explore_related_biographies"
    t.string "Published_Authors"
    t.string "The_Treasury_of_Lives_is_a_bibliographical_encyclopedia_of"
    t.string "Countries_with_active_visitors_on_the_site"
    t.string "Biographies_presently_on_the_site"
    t.string "Scholars_and_practitioners_have_contributed_to_the_project", limit: 1000
    t.string "Tibetan_Plateau"
    t.string "Amdo", limit: 100
    t.string "Kham", limit: 100
    t.string "Ladakh", limit: 45
    t.string "Ngari", limit: 100
    t.string "Tsang", limit: 100
    t.string "U", limit: 45
    t.string "Lhasa_sites"
    t.string "Downloads"
    t.string "Thank_you_to_our_cartographer_Karl_Ryavec_of_UC_Merced"
    t.string "PRINT", limit: 45
    t.string "Staff", limit: 45
    t.string "Editorial_Committee_Members", limit: 45
    t.string "Advisory_Committee_Members", limit: 45
    t.string "Social_Role", limit: 45
    t.string "Vocation", limit: 45
    t.string "Government_Officers", limit: 45
    t.string "people", limit: 45
    t.string "time", limit: 45
    t.string "resources", limit: 45
    t.string "my_account", limit: 45
    t.string "images", limit: 40
  end

  create_table "localization_item", primary_key: "localization_item_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "language", limit: 7
    t.string "type", limit: 24
    t.text "localization"
    t.string "tbrc_id", limit: 45
    t.index ["tbrc_id", "language", "type"], name: "localization_item-tbrc_id-language-type"
  end

  create_table "map", primary_key: "map_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 1000
    t.string "image", limit: 1000
    t.text "description", limit: 4294967295
    t.string "center", limit: 45, default: "28.10000,100.26667"
    t.string "zoom", limit: 45, default: "4"
    t.text "html", limit: 4294967295
  end

  create_table "map_community_xref", primary_key: "map_community_xref_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "map_id", null: false
    t.integer "community_id", null: false
    t.integer "priority"
  end

  create_table "map_region", primary_key: "map_region_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", limit: 1000
    t.string "wylie"
    t.string "chinese"
    t.string "lat", limit: 100
    t.string "long", limit: 100
    t.string "region_type", limit: 12
    t.string "html", limit: 1000
    t.string "zoom_min", limit: 100
    t.string "zoom_max", limit: 100
    t.string "type", limit: 7
    t.integer "zoom_level_on_click", default: 15
    t.integer "size"
    t.integer "radius"
    t.string "inverse", limit: 3
    t.string "rotate", limit: 4
    t.string "letter_spacing", limit: 10
    t.index ["type"], name: "map_region-type"
  end

  create_table "marquee", primary_key: "marquee_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 200
    t.string "title_tibetan", limit: 1000
    t.string "title_chinese", limit: 1000
    t.string "background_image", limit: 1000
    t.string "slide_type", limit: 45
    t.string "button", limit: 45
    t.string "button_tibetan"
    t.string "button_chinese"
    t.string "button_link", limit: 200
    t.string "active", limit: 45
    t.string "order", limit: 45
    t.text "paragraph"
    t.text "paragraph_tibetan"
    t.text "paragraph_chinese"
    t.index ["active", "order"], name: "marquee-active-order"
  end

  create_table "name_ordinal", primary_key: ["ordinal", "text"], options: "ENGINE=MyISAM DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ordinal", limit: 5, null: false
    t.string "text", limit: 45, null: false
  end

  create_table "name_type", primary_key: "name_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_type_key", limit: 25, null: false
    t.string "name_type_caption", limit: 50, null: false
  end

  create_table "name_variant", primary_key: "name_variant_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "name_type_id", null: false
    t.integer "encoding_type_id"
    t.integer "language_type_id"
    t.string "name_variant_text", null: false
    t.index ["encoding_type_id"], name: "FK_name_variant_encoding_type_id"
    t.index ["language_type_id"], name: "FK_name_variant_language_type_id"
    t.index ["name_type_id"], name: "fk_name_variant_name_type_id"
    t.index ["person_id"], name: "fk_name_variant_person_id"
  end

  create_table "office", primary_key: "office_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "ordinal_number"
    t.string "ordinal_text", limit: 1000
    t.string "office_name", limit: 1000
    t.string "wylie_name"
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "TBRC_P_ID", limit: 1000
    t.string "published_default_name", limit: 1000
    t.string "start_date", limit: 1000
    t.string "start_date_circa", limit: 1000
    t.string "end_date", limit: 1000
    t.string "end_date_circa", limit: 1000
    t.string "community_TBRC_ID", limit: 1000
    t.string "tradition", limit: 1000
    t.string "office_TBRC_R_ID", limit: 1000
    t.text "description"
    t.string "display_order", limit: 100
  end

  create_table "painting", primary_key: "painting_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "description"
    t.string "har_nbr", limit: 15
    t.string "image_name", limit: 50, null: false
    t.string "thumb_name", limit: 60, null: false
    t.integer "create_user_id", null: false
    t.datetime "create_date"
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date"
    t.integer "publish_type_id", default: 1, null: false
    t.boolean "is_locked", default: false, null: false
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.text "source"
    t.string "type", limit: 60
    t.string "century"
    t.string "tradition"
    t.string "tbrc_gid"
    t.string "artist_name"
    t.string "artist_tbrc_pid"
    t.index ["create_user_id"], name: "fk_painting_create_user_id"
    t.index ["last_modified_user_id"], name: "fk_painting_last_modified_user_id"
    t.index ["lock_user_id"], name: "fk_painting_lock_user_id"
    t.index ["painting_id"], name: "painting_id_UNIQUE", unique: true
    t.index ["publish_type_id"], name: "fk_painting_publish_type_id"
  end

  create_table "painting_map", primary_key: "painting_map_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "coordinates", limit: 20, null: false
    t.string "tbrc_rid", limit: 25
    t.string "default_name"
    t.string "wylie_name"
    t.integer "person_id"
    t.integer "biography_id"
    t.integer "painting_id", null: false, unsigned: true
    t.integer "create_user_id", null: false
    t.datetime "create_date"
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date"
    t.index ["biography_id"], name: "fk_painting_map_biography_id"
    t.index ["create_user_id"], name: "fk_painting_map_create_user_id"
    t.index ["last_modified_user_id"], name: "fk_painting_map_last_modified_user_id"
    t.index ["painting_id", "biography_id", "person_id", "wylie_name", "tbrc_rid", "coordinates", "default_name", "painting_map_id"], name: "ix_painting_map_by_painting"
    t.index ["painting_id"], name: "fk_painting_map_painting_id"
    t.index ["painting_map_id"], name: "painting_map_id_UNIQUE", unique: true
    t.index ["person_id"], name: "fk_painting_map_person_id"
  end

  create_table "person", primary_key: "person_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tbrc_rid", limit: 25
    t.string "default_name", limit: 100, null: false
    t.string "wylie_name", limit: 100
    t.string "wylie_name_script"
    t.integer "birth_year", default: 0
    t.integer "death_year", default: 0
    t.boolean "birth_approx", default: false, null: false, unsigned: true
    t.boolean "death_approx", default: false, null: false, unsigned: true
    t.string "lived", limit: 125
    t.string "gender", limit: 1
    t.string "har_url", limit: 75
    t.integer "landmark_id"
    t.integer "geography_id"
    t.integer "community_id"
    t.integer "historical_period_id"
    t.integer "tradition_id"
    t.boolean "is_locked", default: false, null: false
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id"
    t.datetime "last_modified_date"
    t.boolean "is_indexed", default: false, null: false
    t.boolean "is_deleted", default: false, null: false, unsigned: true
    t.integer "birth_century_id", unsigned: true
    t.integer "death_century_id", unsigned: true
    t.string "birth_estimated", limit: 30
    t.string "death_estimated", limit: 30
    t.string "default_title", limit: 50
    t.string "wylie_title", limit: 50
    t.string "published_default_name"
    t.string "published_wylie_name"
    t.string "ordinal", limit: 5
    t.string "url_default_name", limit: 150
    t.string "url_wylie_name", limit: 150
    t.string "person_type", limit: 45
    t.index ["birth_century_id"], name: "fk_person_birth_century_id"
    t.index ["community_id"], name: "fk_person_community_id"
    t.index ["create_user_id"], name: "fk_person_create_user_id"
    t.index ["death_century_id"], name: "fk_person_death_century_id"
    t.index ["geography_id"], name: "fk_person_geography_id"
    t.index ["historical_period_id"], name: "fk_person_historical_period_id"
    t.index ["landmark_id"], name: "fk_person_landmark_id"
    t.index ["last_modified_user_id"], name: "fk_person_last_modified_user_id"
    t.index ["lock_user_id"], name: "fk_person_lock_user_id"
    t.index ["published_default_name"], name: "person-published_default_name"
    t.index ["tbrc_rid"], name: "ix_person_tbrc_rid"
    t.index ["tradition_id"], name: "fk_person_tradition_id"
  end

  create_table "person_community_xref", primary_key: ["person_id", "community_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "community_id", null: false
    t.index ["community_id"], name: "fk_person_community_xref_community_id"
  end

  create_table "person_geography_xref", primary_key: ["person_id", "geography_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "geography_id", null: false
    t.index ["geography_id"], name: "fk_person_geography_xref_geography_id"
  end

  create_table "person_historical_period_xref", primary_key: ["person_id", "historical_period_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "historical_period_id", null: false
    t.index ["historical_period_id"], name: "fk_person_historical_period_xref_history_id"
  end

  create_table "person_image", primary_key: "person_image_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "image_file_name", limit: 50, null: false
    t.string "thumb_file_name", limit: 60, null: false
    t.string "har_number", limit: 15
    t.string "image_credit", limit: 50
    t.integer "is_primary", default: 0, null: false, unsigned: true
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id"
    t.datetime "last_modified_date"
    t.index ["create_user_id"], name: "FK_person_image_create_user_id"
    t.index ["last_modified_user_id"], name: "FK_person_image_last_modified_user_id"
    t.index ["person_id", "image_file_name", "thumb_file_name", "is_primary"], name: "IX_person_image_person_id"
  end

  create_table "person_landmark_xref", primary_key: ["person_id", "landmark_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "landmark_id", null: false
    t.index ["landmark_id"], name: "fk_person_landmark_xref_landmark_id"
  end

  create_table "person_tradition_xref", primary_key: ["person_id", "tradition_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "tradition_id", null: false
    t.boolean "is_primary", default: false, null: false, unsigned: true
    t.index ["tradition_id"], name: "fk_person_tradition_xref_tradition_id"
  end

  create_table "publish_type", primary_key: "publish_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "publish_type_name", limit: 25, null: false
    t.boolean "is_active", default: true
  end

  create_table "resource", primary_key: "resource_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "resource_category_id", null: false
    t.string "link", null: false
    t.string "title", null: false
    t.string "description", limit: 1024
    t.boolean "is_locked", default: false, null: false
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date", null: false
    t.boolean "is_deleted", default: false, null: false
    t.index ["create_user_id"], name: "fk_resource_create_user_id"
    t.index ["last_modified_user_id"], name: "fk_resource_last_modified_user_id"
    t.index ["lock_user_id"], name: "fk_resource_lock_user_id"
    t.index ["resource_category_id", "is_deleted", "last_modified_date"], name: "ix_resource_lookup"
  end

  create_table "resource_category", primary_key: "resource_category_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category_name", limit: 75, null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "revision", primary_key: "revision_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "contribution_id", null: false, unsigned: true
    t.string "document_name", null: false
    t.timestamp "create_stamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["contribution_id", "revision_id", "document_name", "create_stamp"], name: "ix_revision_cover"
    t.index ["contribution_id"], name: "fk_revision_contribution_id"
    t.index ["revision_id"], name: "revision_id_UNIQUE", unique: true
  end

  create_table "saved_biography", primary_key: ["biography_id", "user_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "biography_id", null: false, unsigned: true
    t.integer "user_id", null: false, unsigned: true
    t.datetime "save_date", null: false
  end

  create_table "search", primary_key: "search_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "session_id", limit: 45, null: false
    t.datetime "last_access_date", null: false
    t.string "geography_facet", limit: 400
    t.string "tradition_facet", limit: 400
    t.string "landmark_facet", limit: 100, comment: "Not increasing the size of this field since it has been deprecated"
    t.string "historical_period_facet", limit: 400
    t.string "community_facet", limit: 1024
    t.string "search_string", limit: 1024
    t.string "order_by", limit: 100
    t.text "id_list", limit: 4294967295
    t.integer "result_count", default: 0, null: false, unsigned: true
    t.integer "current_page", default: 1, null: false, unsigned: true
    t.integer "search_type_id", default: 1, null: false
    t.boolean "exclude_non_bios", default: false, unsigned: true
    t.integer "primary_lineage_count", default: 0, unsigned: true
    t.boolean "exclude_non_primary", default: false, null: false, unsigned: true
    t.integer "author_id", unsigned: true
    t.text "normalized_search_string"
    t.boolean "only_peer_reviewed", default: false, null: false
    t.index ["author_id"], name: "fk_search_author_id"
    t.index ["search_type_id"], name: "fk_search_search_type_id"
    t.index ["session_id", "last_access_date"], name: "search-session_id-last_access_date"
  end

  create_table "search_archive", primary_key: "search_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "session_id", limit: 45, null: false
    t.datetime "last_access_date", null: false
    t.string "geography_facet", limit: 400
    t.string "tradition_facet", limit: 400
    t.string "landmark_facet", limit: 100, comment: "Not increasing the size of this field since it has been deprecated"
    t.string "historical_period_facet", limit: 400
    t.string "community_facet", limit: 1024
    t.string "search_string", limit: 1024
    t.string "order_by", limit: 100
    t.string "id_list", limit: 2048
    t.integer "result_count", default: 0, null: false, unsigned: true
    t.integer "current_page", default: 1, null: false, unsigned: true
    t.integer "search_type_id", default: 1, null: false
    t.boolean "exclude_non_bios", default: false, unsigned: true
    t.integer "primary_lineage_count", default: 0, unsigned: true
    t.boolean "exclude_non_primary", default: false, null: false, unsigned: true
    t.integer "author_id", unsigned: true
    t.text "normalized_search_string"
    t.boolean "only_peer_reviewed", default: false, null: false
  end

  create_table "search_type", primary_key: "search_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "search_type_name", limit: 45, null: false
  end

  create_table "seat", primary_key: "seat_id", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "office_rid", limit: 15, collation: "latin1_swedish_ci"
    t.string "office_wylie", limit: 500, collation: "latin1_swedish_ci"
    t.string "office_english", limit: 100, collation: "latin1_swedish_ci"
    t.string "place_rid", limit: 15, collation: "latin1_swedish_ci"
    t.string "place_wylie", limit: 100, collation: "latin1_swedish_ci"
    t.string "place_english", limit: 200, collation: "latin1_swedish_ci"
    t.integer "year", unsigned: true
    t.string "circa", limit: 25, collation: "latin1_swedish_ci"
    t.string "event_type", limit: 25, collation: "latin1_swedish_ci"
    t.boolean "is_seat_node", default: false, null: false, unsigned: true
    t.index ["office_rid", "place_rid", "person_id", "is_seat_node", "year", "event_type"], name: "idx_seat_office_lookup"
    t.index ["person_id"], name: "fk_seat_person_id"
  end

  create_table "site_content", primary_key: "site_content_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "site_page_id", null: false
    t.text "content_text", null: false, collation: "latin1_swedish_ci"
    t.integer "create_user_id", null: false
    t.datetime "create_date", null: false
    t.integer "last_modified_user_id", null: false
    t.datetime "last_modified_date", null: false
    t.boolean "is_locked", default: false, null: false
    t.integer "lock_user_id"
    t.datetime "lock_date"
    t.string "image_file_name", limit: 45
    t.index ["lock_user_id"], name: "fk_site_content_lock_user_id"
    t.index ["site_page_id"], name: "fk_site_content_site_page_id"
  end

  create_table "site_images", primary_key: "site_resource_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.string "link"
    t.integer "display_order"
    t.string "active", limit: 3, default: "yes"
  end

  create_table "site_page", primary_key: "site_page_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "site_page_name", limit: 50, null: false, collation: "latin1_swedish_ci"
  end

  create_table "site_resource", primary_key: "site_resource_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.string "link"
    t.integer "display_order"
    t.string "active", limit: 3, default: "yes"
  end

  create_table "spelling", primary_key: ["canonical", "variant"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "canonical", limit: 45, null: false
    t.string "variant", limit: 45, null: false
    t.string "wylie", limit: 45
    t.integer "spelling_id", null: false, unsigned: true, auto_increment: true
    t.index ["spelling_id", "canonical", "variant", "wylie"], name: "ix_spelling_cover"
    t.index ["spelling_id"], name: "spelling_id_UNIQUE", unique: true
  end

  create_table "sponsor", primary_key: "sponsor_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "sponsor_name", limit: 128, null: false
    t.string "sponsor_url", limit: 256
    t.text "sponsor_description"
    t.index ["sponsor_name"], name: "sponsor-sponsor_name", unique: true
  end

  create_table "standards_document", primary_key: "standards_document_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.string "filename", limit: 256
    t.string "description", limit: 512
    t.integer "display_order", limit: 1, default: 1, null: false
    t.string "external_url", limit: 256
  end

  create_table "tradition", primary_key: "tradition_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tradition_name", limit: 50, null: false
    t.string "wylie_name", limit: 50
    t.string "wylie_name_script"
    t.string "chinese_name"
    t.string "image_file_name", limit: 50
    t.text "description"
    t.string "blurb", limit: 1024
  end

  create_table "tradition_facet", primary_key: "tradition_facet_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tradition_hierarchy_id", null: false
    t.integer "person_id"
    t.boolean "is_primary", default: false, null: false, unsigned: true
    t.index ["tradition_hierarchy_id"], name: "fk_tradition_facet_tradition_hierarchy_id"
  end

  create_table "tradition_hierarchy", primary_key: "tradition_hierarchy_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tradition_id", null: false
    t.integer "parent_tradition_id"
    t.integer "ordinal"
    t.index ["parent_tradition_id"], name: "fk_tradition_hierarchy_parent_tradition_id"
    t.index ["tradition_id"], name: "fk_tradition_hierarchy_tradition_id"
  end

  create_table "user", primary_key: "user_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.string "email_address", limit: 75, null: false
    t.binary "password", null: false
    t.integer "user_type_id", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "create_date", null: false
    t.datetime "last_modified_date"
    t.integer "last_modified_user_id"
    t.integer "create_user_id"
    t.datetime "last_login_date"
    t.string "nickname", limit: 30
    t.boolean "is_peer", default: false, null: false
    t.index ["create_user_id"], name: "fk_user_create_user_id"
    t.index ["last_modified_user_id"], name: "fk_user_modified_user_id"
    t.index ["user_id", "email_address", "user_type_id", "is_active"], name: "fk_user_login"
    t.index ["user_type_id", "is_peer", "first_name", "last_name", "nickname"], name: "ix_user_search"
    t.index ["user_type_id"], name: "fk_user_user_type_id"
  end

  create_table "user_type", primary_key: "user_type_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_type_name", limit: 45, null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "view_history", primary_key: ["user_id", "biography_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "biography_id", null: false
    t.datetime "view_date", null: false
    t.index ["biography_id"], name: "fk_view_history_biography_id"
    t.index ["user_id", "biography_id", "view_date"], name: "idx_view_history_cover"
  end

end
